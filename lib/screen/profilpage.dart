import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usermodel.dart';
import '../screen/homepage.dart';
import '../widgets/mybutton.dart';
import '../widgets/textField.dart';
import '../widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel userModel;
  TextEditingController phoneNumber;
  TextEditingController address;
  TextEditingController userName;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  bool isMale = false;
  void vaildation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (userName.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    }
    else if (phoneNumber.text.length < 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  File _pickedImage;

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  String userUid;

  Future<String> _uploadImage({File image}) async {
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child("UserImage/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("User").doc(userUid).update({
      "UserName": userName.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
      "UserImage": imageMap,
      "UserAddress": address.text
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _SingleContainer(
      {Color color, String startText, String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.black12,
          borderRadius: edit == false
              ? BorderRadius.circular(20)
              : BorderRadius.circular(1),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              endText,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45

              ),
            ),
          ],
        ),
      ),
    );
  }

  String userImage;
  bool edit = false;
  Widget _ContainerPart() {
    address = TextEditingController(text: userModel.userAddress);
    userName = TextEditingController(text: userModel.userName);
    phoneNumber = TextEditingController(text: userModel.userPhoneNumber);
    if (userModel.userGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SingleContainer(
            endText: userModel.userName,
            startText: "Name :",
          ),
          _SingleContainer(
            endText: userModel.userEmail,
            startText: "Email :",
          ),
          _SingleContainer(
            endText: userModel.userGender,
            startText: "Gender :",
          ),
          _SingleContainer(
            endText: userModel.userPhoneNumber,
            startText: "Phone Number :",
          ),
          _SingleContainer(
            endText: userModel.userAddress,
            startText: "Address :",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Take Photo"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera_back),
                    title: Text("Phone Storage"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _Editform() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "Name: ",
            controller: userName,
          ),
          _SingleContainer(
            color: Colors.grey[300],
            endText: userModel.userEmail,
            startText: "Email: ",
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: _SingleContainer(
              color: Colors.white,
              endText: isMale == true ? "Male" : "Female",
              startText: "Gender?",
            ),
          ),
          MyTextFormField(
            name: "Phone Number: ",
            controller: phoneNumber,
          ),
          MyTextFormField(
            name: "Address: ",
            controller: address,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.greenAccent[700],
        leading: edit == true
            ? IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.redAccent,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              edit = false;
            });
          },
        )
            : IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            });
          },
        ),
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
            icon: Icon(
              Icons.save,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () {
              vaildation();
            },
          ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var myDoc = snapshot.data.docs;
                myDoc.forEach((checkDocs) {
                  if (checkDocs.data()["UserId"] == userUid) {
                    userModel = UserModel(
                      userEmail: checkDocs.data()["UserEmail"],
                      userImage: checkDocs.data()["UserImage"],
                      userAddress: checkDocs.data()["UserAddress"],
                      userGender: checkDocs.data()["UserGender"],
                      userName: checkDocs.data()["UserName"],
                      userPhoneNumber: checkDocs.data()["UserNumber"],
                    );
                  }
                });
                return Container(
                  height: 603,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    maxRadius: 65,
                                    backgroundImage: _pickedImage == null
                                        ? userModel.userImage == null
                                        ? AssetImage("images/userImage.png")
                                        : NetworkImage(userModel.userImage)
                                        : FileImage(_pickedImage)),
                              ],
                            ),
                          ),
                          edit == true
                              ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).viewPadding.left + 220,
                                top: MediaQuery.of(context).viewPadding.left + 110
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  myDialogBox(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                  Colors.transparent,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.greenAccent[700],
                                  ),
                                ),
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: edit == true
                                    ? _Editform()
                                    : _ContainerPart(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: edit == false
                              ? MyButton(
                            name: "Edit Profile",
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                          )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
