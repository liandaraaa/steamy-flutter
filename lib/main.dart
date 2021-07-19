import 'package:flutter/material.dart';
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            },
            child: Text('Submit'),
          )
        ],
      ),
    ));
  }
}

class HomeScreen extends StatelessWidget {
  String phoneNumber = "0829321299";

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
                'No Hp : $phoneNumber',
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
        child: SingleChildScrollView(
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
                      'Your Points : 100pts',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
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
                Text(
                  '05:00',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              '${meal.image}',
                              fit: BoxFit.fill,
                            )),
                      );
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network('${drink.image}')),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                              style: TextStyle(fontWeight: FontWeight.bold),)),
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
