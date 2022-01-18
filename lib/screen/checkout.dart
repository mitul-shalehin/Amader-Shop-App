import 'package:amadershop/screen/cartpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/cartmodel.dart';

import '../pagelink/product_linker.dart';
import '../screen/homepage.dart';
import '../widgets/checkout_singleproduct.dart';
import '../widgets/mybutton.dart';
import '../widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle = TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   ProductLinker P_Provider;

  Widget _buildBottomSingleDetail({String startName, String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }

  User user;
  double total;
  List<CartModel> myList;

  Widget _buildButton() {
    return Column(
        children: P_Provider.userModelList.map((e) {
          return Container(
            height: 50,
            child: MyButton(
              name: "Order Now",
              onPressed: () {
                if (P_Provider.getCheckOutModelList.isNotEmpty) {
                  FirebaseFirestore.instance.collection("Order").add({
                    "Product": P_Provider.getCheckOutModelList
                        .map((c) => {
                      "ProductImage": c.image,
                      "ProductName": c.name,
                      "ProductPrice": c.price,
                      "ProductQuetity": c.quentity,

                    })
                        .toList(),
                    "TotalPrice": total.toString(),
                    "UserName": e.userName,
                    "UserEmail": e.userEmail,
                    "UserNumber": e.userPhoneNumber,
                    "UserAddress": e.userAddress,
                    "UserId": user.uid,
                  });
                  setState(() {
                    myList.clear();
                  });

                  P_Provider.addNotification("Notification");
                } else {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text("Select you items"),
                    ),
                  );
                }
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomePage(),
                  ),
                );
              },
            ),
          );
        }).toList());
  }

  @override
  void initState() {
    P_Provider = Provider.of<ProductLinker>(context, listen: false);
    myList = P_Provider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    int subTotal = 0;
    int shipping = 150;
    int total=0;

    P_Provider = Provider.of<ProductLinker>(context);
    P_Provider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quentity;
    });
    total = subTotal + shipping;
    if (P_Provider.checkOutModelList.isEmpty) {
      total = 0;
      shipping = 0;
    }

    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomePage(),
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("CheckOut Page", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.greenAccent[700],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CartPage(),
                ),
              );
            },
          ),
          actions: <Widget>[

            IconButton(icon: Icon(Icons.home_rounded,color: Colors.black),
                onPressed:(){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => HomePage()));
                } ),
            NotificationButton(),
          ],

        ),
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(bottom: 15),
          child: _buildButton(),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (ctx, myIndex) {
                      return CheckOutSingleProduct(
                        index: myIndex,
                        image: myList[myIndex].image,
                        name: myList[myIndex].name,
                        price: myList[myIndex].price,
                        quentity: myList[myIndex].quentity,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBottomSingleDetail(
                        startName: "Subtotal",
                        endName: "\ ${subTotal.toString()} Taka",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Shipping",
                        endName: "\$ ${shipping.toString()} Taka",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Total",
                        endName: "\ ${total.toString()} Taka",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}