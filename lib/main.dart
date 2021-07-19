import 'package:flutter/material.dart';
import 'package:steam_app/model/drink.dart';
import 'package:steam_app/model/meal.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text('Steamy'),
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
                      'Your Points : 100',
                      style: TextStyle(color: Colors.blueAccent),
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
