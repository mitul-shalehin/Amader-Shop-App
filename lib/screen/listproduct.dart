import 'package:amadershop/model/products.dart';
import 'package:amadershop/screen/cartpage.dart';

import '../model/products.dart';
import '../pagelink/catagory_linker.dart';
import '../pagelink/product_linker.dart';
import '../screen/detailpage.dart';

import '../screen/homepage.dart';
import '../screen/search_category.dart';
import '../screen/search_product.dart';
import '../widgets/notification_button.dart';

import '../widgets/singeproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
  final String name;
  bool isCategory = true;
  final List<Product> snapShot;
  ListProduct({
    this.name,
    this.isCategory,
    this.snapShot,
  });

  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _GridViewofProduct(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 600,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        scrollDirection: Axis.vertical,
        children: snapShot.map((e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                            image: e.image,
                            name: e.name,
                            price: e.price,
                          )));
                },
                child: SingleProduct(
                  price: e.price,
                  image: e.image,
                  name: e.name,
                ),
              ),
            ).toList(),
      ),
    );
  }
  CategoryLinker C_Provider;
  ProductLinker P_Provider;
  Widget _buildSearchBar(context) {
    return isCategory == true
        ? IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              C_Provider.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchCategory());
            },
          )
        : IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              P_Provider.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchProduct());
            },
          );
  }

  @override
  Widget build(BuildContext context) {
   C_Provider = Provider.of<CategoryLinker>(context);
    P_Provider = Provider.of<ProductLinker>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name,style:TextStyle(color: Colors.black),),
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

        actions: [
          _buildSearchBar(context),
          IconButton(icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black),
              onPressed:(){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => CartPage()));
              } ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            SizedBox(
              height: 10,
            ),
            _GridViewofProduct(context),
          ],
        ),
      ),
    );
  }
}
