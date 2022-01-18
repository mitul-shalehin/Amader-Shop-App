import 'package:amadershop/screen/cartpage.dart';

import '../screen/checkout.dart';
import '../screen/homepage.dart';
import '../widgets/mybutton.dart';
import '../widgets/notification_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import '../pagelink/product_linker.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int price;
  final String details;
  DetailScreen({this.image, this.name, this.price,this.details});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
 ProductLinker productProvider;

  final TextStyle myStyle = TextStyle(
    fontSize: 25,fontWeight: FontWeight.bold
  );
  Widget _Image() {
    return Center(
      child: Container(
        width: 250,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(

                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ProductNameInfo() {
    return Container(
      height: 150,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.name, style: myStyle),
              Text(
                "\ Price: ${widget.price.toString()} Taka",
                style: TextStyle(
                    color: Colors.greenAccent[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text("Rating", style: myStyle),
              RatingBarIndicator(
                rating: 3.50,
                itemBuilder: (context,index) => Icon(
                  Icons.star,
                ),
                itemCount: 5,
                itemSize: 30,
                direction:  Axis.horizontal,
              ),

              Text("Description", style: myStyle),
            ],
          ),
        ],
      ),
    );
  }


  Widget _Discription() {
    return Container(
      height: 130,
      child: Wrap(
        children: <Widget>[
          Text("Amader Shop\n"
              "All Products Are Genuine\n"
              "We prodive Official Warrenty\n"
              "All Colors Available \n"
              "If You Need any kind of information just visit our Webpage\n"
              "Or you call Call our Hotline : 661233\n"
              "ALl products are 02 years warranty",
            style: TextStyle(fontSize: 13,color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Widget _Quentity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "Quantity",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.greenAccent[700],
              borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.black,
                ),
                onTap: () {
                  setState(() {
                    if (count > 1) {
                        count--;
                    }
                  });
                },
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              GestureDetector(
                child: Icon(
                  Icons.add_circle,
                  color: Colors.black,
                ),
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _BuyButton() {
    return Container(
      height: 45,
      child: MyButton(
        name: "Add To Cart",
        onPressed: () {
          productProvider.getCheckOutData(
            image: widget.image,
            name: widget.name,
            price: widget.price,


            quentity: count,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CartPage(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductLinker>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Detail Page", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.greenAccent[700],
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
            },
          ),
            actions: [
              IconButton(icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black),
                  onPressed:(){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => CartPage()));
                  } ),
            ]
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              _Image(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _ProductNameInfo(),
                    SizedBox(
                      height: 20,
                    ),

                    _Discription(),
                    _Quentity(),

                    SizedBox(
                      height: 15,
                    ),
                    _BuyButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  }
}
