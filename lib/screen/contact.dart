import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/usermodel.dart';
import '../pagelink/product_linker.dart';
import '../screen/homepage.dart';
import '../widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController message = TextEditingController();

  String name, email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void vaildation() async {
    if (message.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Message Blank"),
        ),
      );
    } else {
      User user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
    }
  }

  Widget _buildSingleFlied({String name}) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    ProductLinker provider;
    provider = Provider.of<ProductLinker>(context, listen: false);
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.userName;
      email = e.userEmail;

      return Container();
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Contact Us",style:TextStyle(color: Colors.black),),
          backgroundColor: Colors.greenAccent[700],
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomePage(),
                  ),
                );
              }),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 27),
          height: 600,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sent Us Your Message",
                style: TextStyle(
                  color: Colors.greenAccent[700],
                  fontSize: 28,
                  fontWeight:FontWeight.bold
                ),
              ),
              _buildSingleFlied(name: name),
              _buildSingleFlied(name: email),
              Container(
                height: 200,
                child: TextFormField(
                  controller: message,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: " Message",
                  ),
                ),
              ),
              MyButton(
                name: "Submit",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => HomePage()));
                      vaildation();
                },
              )
            ],
          ),
        ),
      );

  }
}
