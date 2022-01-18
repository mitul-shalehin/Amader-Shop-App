import '../screen/login.dart';
import '../screen/signup.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 600,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              //fit: BoxFit.cover,
                              image: AssetImage("images/welcome_logo.png"))),
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Text("TO ",
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                          ),
                          Text("Amader Shop",
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Get Start",
                          style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),
                        )
                      ],

                    ),
                    Container(
                      height: 35,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("Sign Up",
                          style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        color: Colors.greenAccent[700],
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => SignUp(),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Already have an account?",
                          style: TextStyle(fontSize: 15,color: Colors.black),
                        )
                      ],

                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text("Login",
                          style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        color: Colors.greenAccent[700],
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) =>Login(),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
