import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:steam_app/model/drink.dart';
import 'package:steam_app/model/meal.dart';
import 'package:steam_app/model/vehicle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steamy',
      theme: ThemeData(),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(top: 200.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write your phone number here...',
                labelText: 'Phone Number',
              ),
              onChanged: (String value) {
                phoneNumber = value;
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (phoneNumber.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Please input your phone number'),
                      );
                    });
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen(phoneNumber);
                }));
              }
            },
            child: Text('Submit'),
          )
        ],
      ),
    ));
  }
}

class HomeScreen extends StatelessWidget {
  final String phoneNumber;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  HomeScreen(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steamy'),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                  child: Text(
                'Phone Number : $phoneNumber',
                style: TextStyle(color: Colors.white),
              )),
            ),
            ListTile(
              title: Text('Washing History'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WashingHistoryScreen();
                }));
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: WashingTimer(timer: endTime),
      ),
    );
  }
}

class WashingTimer extends StatefulWidget {
  final int timer;

  const WashingTimer({required this.timer});

  @override
  State createState() => WashingTimerStates();
}

class WashingTimerStates extends State<WashingTimer>
    with TickerProviderStateMixin {
  late CountdownTimerController controller;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: widget.timer, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hi, Welcome'),
                Text(
                  'Your Points : 400pts',
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
              child: Text(
                'Your Washing Will Be Finish In',
                textAlign: TextAlign.center,
              ),
            ),
            CountdownTimer(
              controller: controller,
              onEnd: onEnd,
              endTime: widget.timer,
              widgetBuilder: (context, CurrentRemainingTime? time) {
                if (time == null) {
                  return ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('Thank You'),
                              );
                            });
                      },
                      child: Text('Complete Payment'));
                }
                return Text(
                  '${time.min ?? 00} : ${time.sec}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
              child: Text(
                'You will be noticed when your washing completed, so stay calm and just wait. Please enjoy the meals in our cozy restaurant!',
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Meals',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: meals.map((meal) {
                  return BiggerImage(image: '${meal.image}');
                }).toList(),
              ),
            ),
            Text(
              'Drinks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: drinks.map((drink) {
                  return BiggerImage(image: '${drink.image}');
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class BiggerImage extends StatefulWidget {
  final String image;

  const BiggerImage({required this.image});

  @override
  BiggerImageState createState() => BiggerImageState();
}

class BiggerImageState extends State<BiggerImage> {
  double imageSize = 200.0;
  bool isZoom = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isZoom = !isZoom;
          if (isZoom) {
            imageSize = 300.0;
          } else {
            imageSize = 200.0;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              '${widget.image}',
              width: imageSize,
              height: imageSize,
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}

class WashingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Washing History'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final Vehicle vehicle = vehicles[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${vehicle.date}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                '${vehicle.policyNumber}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Text('Duration : ${vehicle.duration}'),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Congratulations,',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'You Got This Points',
                                style: TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                          Text(
                            '${vehicle.point}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: vehicles.length,
          ),
        ));
  }
}
