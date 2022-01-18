import '../pagelink/product_linker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutSingleProduct extends StatefulWidget {
  final int index;
  final String name;
  final String image;
  final quentity;
  final int price;
  CheckOutSingleProduct({this.index, this.quentity, this.image, this.name, this.price,});

  @override
  _CheckOutSingleProductState createState() => _CheckOutSingleProductState();
}

TextStyle myStyle = TextStyle(fontSize: 14,fontWeight: FontWeight.bold);
ProductLinker P_Provider;

class _CheckOutSingleProductState extends State<CheckOutSingleProduct> {
  double height, width;
  Widget _Image() {
    return Container(
      height: height * 0.05 + 60,
      width: width * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.image),
        ),
      ),
    );
  }

  Widget _NameAndRemove() {
    return Container(
      height: 50,
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            widget.name,
            style: myStyle,
          ),
          IconButton(
            icon: Icon(Icons.highlight_remove,color: Colors.red,),
            onPressed: () {
              P_Provider.deleteCheckoutProduct(widget.index);
            },
          ),
        ],
      ),
    );
  }


  Widget _CountOrNot() {
    return Container(
      height: 30,
      width: width * 0.15 + 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Quantity:",style:TextStyle(fontSize: 14,)),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              widget.quentity.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    P_Provider = Provider.of<ProductLinker>(context);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _Image(),
                Container(
                  height: height * 0.1 + 50,
                  width: width * .6,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[

                        _NameAndRemove(),

                        Text("\ ${widget.price.toString()} Taka",
                          style: TextStyle(
                              color: Colors.greenAccent[700],
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        _CountOrNot(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
