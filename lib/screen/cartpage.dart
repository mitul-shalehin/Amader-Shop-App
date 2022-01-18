
import 'package:amadershop/screen/checkout.dart';
import 'package:amadershop/screen/homepage.dart';
import '../widgets/checkout_singleproduct.dart';
import '../pagelink/product_linker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}
ProductLinker P_Provider;

class _CartPageState extends State<CartPage> {
  @override

  @override
  Widget build(BuildContext context) {
    P_Provider= Provider.of<ProductLinker>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 45,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(bottom: 5),
        child: RaisedButton(
          color: Colors.greenAccent[700],
          child: Text("Payment",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          onPressed: (){
            P_Provider.addNotification("Notification");
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx)=>CheckOut(),
                ),
            );


          },
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart Page",style:TextStyle(color: Colors.black),),
        backgroundColor: Colors.greenAccent[700],
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed:(){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx)=>HomePage(),
              ),
            );


        }

        ),
        actions: [
          IconButton(icon: Icon(Icons.home_rounded,color: Colors.black),
              onPressed:(){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => HomePage()));
              } ),
        ],



      ),
      body: ListView.builder(
        itemCount:  P_Provider.getCheckOutModelListLength,
        itemBuilder: (ctx,index)=> CheckOutSingleProduct(
          index: index,
          image: P_Provider.getCheckOutModelList[index].image,
          name: P_Provider.getCheckOutModelList[index].name,
          price: P_Provider.getCheckOutModelList[index].price,
          quentity: P_Provider.getCheckOutModelList[index].quentity,

        )



      ),
    );
  }
}
