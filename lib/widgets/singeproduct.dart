import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final int price;
  final String name;
  SingleProduct({this.image, this.name, this.price});
  @override
  Widget build(BuildContext context) {
    double width, height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        height: height * 0.3,
        width: width * 0.2 * 2 + 5,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(

                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Text(
                    "\ Price: ${price.toString()} Taka",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.greenAccent[700]
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
