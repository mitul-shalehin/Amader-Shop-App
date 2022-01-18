import 'package:amadershop/screen/cartpage.dart';
import 'package:amadershop/screen/welcompage.dart';

import '../model/categoryicons.dart';
import '../model/usermodel.dart';
import '../screen/search_category.dart';
import '../screen/about.dart';
import '../screen/checkout.dart';

import '../screen/contact.dart';
import '../screen/login.dart';

import '../screen/profilpage.dart';

import '../pagelink/product_linker.dart';
import '../pagelink/catagory_linker.dart';
import '../screen/detailpage.dart';
import '../screen/listproduct.dart';
import '../widgets/singeproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import '../model/products.dart';
import '../widgets/notification_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


CategoryLinker C_Provider;
ProductLinker P_Provider;



class _HomePageState extends State<HomePage> {
  Widget _CategoryDesign(String image) {
    return CircleAvatar(
      maxRadius: 40,
      backgroundColor: Colors.greenAccent[700],

      child: Container(
        height: 50,
        child: Image(
          image: NetworkImage(image),
        ),
      ),


    );
  }

  double height, width;
  bool profile = false;

  bool home = true;

  bool checkout = false;

  bool about = false;

  bool contact = false;

  bool logout = false;

  MediaQueryData mediaQuery;

  Widget _AppDrawer() {
    List<UserModel> userModel = P_Provider.userModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          e.userName,
          style: TextStyle(color: Colors.black),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.black12,
          backgroundImage: e.userImage == null
              ? AssetImage("images/userImage.png")
              : NetworkImage(e.userImage),
        ),
        decoration: BoxDecoration(color: Colors.greenAccent[700]),
        accountEmail: Text(e.userEmail, style: TextStyle(color: Colors.black)),
      );
    }).toList());
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _AppDrawer(),
          ListTile(
            selected: profile,
            onTap: () {
              setState(() {
                about = false;
                contact = false;
                home = false;
                profile = true;
                checkout = false;
                logout = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ProfileScreen(),
                ),
              );
            },
            leading: Icon(Icons.supervised_user_circle_sharp),
            title: Text("Profile"),
          ),
          ListTile(
            selected: home,
            onTap: () {
              setState(() {
                home = true;
                contact = false;
                checkout = false;
                about = false;
                profile = false;
                logout = false;
              });
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),

          ListTile(
            selected: checkout,
            onTap: () {
              setState(() {
                checkout = true;
                contact = false;
                home = false;
                profile = false;
                about = false;
                logout = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => CheckOut()));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Checkout"),
          ),

          ListTile(
            selected: contact,
            onTap: () {
              setState(() {
                contact = true;
                checkout = false;
                profile = false;
                home = false;
                about = false;
                logout = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => ContactUs()));
            },
            leading: Icon(Icons.message_rounded),
            title: Text("Contant Us"),
          ),
          ListTile(
            selected: profile,
            onTap: () {
              setState(() {
                about = true;
                contact = false;
                home = false;
                profile = false;
                checkout = false;
                logout = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => About(),
                ),
              );
            },
            leading: Icon(Icons.info_outline_rounded),
            title: Text("About"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }

  Widget _ImageSlider() {
    return Container(
        height: 130,

        child: Carousel(
          dotColor: Colors.black,
          autoplay: true,
          dotSize: 5,
          images: [
            AssetImage("images/web_fornt2.png"),
            AssetImage("images/web_front.PNG"),

          ],
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.greenAccent.withOpacity(0.5),
          borderRadius: true,
        )
    );
  }

  Widget _MouseIcon() {
    List<CategoryIcons> MouseIcon = C_Provider.getMouseIcon;
    List<Product> Mouse = C_Provider.getMouseList;
    return Row(
        children: MouseIcon.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(
                    name: "Mouse",
                    snapShot: Mouse,
                  ),
                ),
              );
            },
            child: _CategoryDesign(e.image,),
          );
        }).toList());
  }

  Widget _KeyBoardIcon() {
    List<CategoryIcons> KeyBoardIcon = C_Provider.getKeyboardIcon;
    List<Product> Keyboard = C_Provider.getKeyboardList;
    return Row(
        children: KeyBoardIcon.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(
                    name: "Keyboard",
                    snapShot: Keyboard,
                  ),
                ),
              );
            },
            child: _CategoryDesign(e.image,),
          );
        }).toList());
  }

  Widget _HeadSetIcon() {
    List<CategoryIcons> HeadsetIcon = C_Provider.getHeadSetIcon;
    List<Product> Headset = C_Provider.getHeadSetList;
    return Row(
        children: HeadsetIcon.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(
                    name: "HeadSet",
                    snapShot: Headset,
                  ),
                ),
              );
            },
            child: _CategoryDesign(e.image,),
          );
        }).toList());
  }

  Widget _MonitorIcon() {
    List<CategoryIcons> MonitorIcon  = C_Provider.getMonitorIcon;
    List<Product> Monitor = C_Provider.getMonitorList;
    return Row(
        children: MonitorIcon.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(
                    name: "Monitor",
                    snapShot:Monitor,
                  ),
                ),
              );
            },
            child: _CategoryDesign(e.image,),
          );
        }).toList());
  }
  

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height:40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Categorie",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 55,
          child: Row(
            children: <Widget>[
              _MouseIcon(),
              _HeadSetIcon(),
              _KeyBoardIcon(),
              _MonitorIcon(),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    List<Product> featureProduct;

    featureProduct = P_Provider.getFeatureList;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Featured",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      isCategory: false,
                      snapShot: featureProduct,
                    ),
                  ),
                );
              },
              child: Text(
                "View more",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: P_Provider.getFeatureHomeList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _ExtraItem() {
    List <Product> ExtraItems = P_Provider.getExtraIteamsList;
    return Column(
      children: [
        Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Extra Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              ListProduct(
                                name: "Extra Items",
                                snapShot: ExtraItems,

                              ),
                        ),
                      );
                    },
                    child: Text("See More", style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: P_Provider.ExtraHome.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              image: e.image, price: e.price, name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    C_Provider.getMouseData();
    C_Provider.getMonitorData();
    C_Provider.getKeyboardData();
    C_Provider.getHeadSetData();
    C_Provider.getMouseIconData();
    P_Provider.getFeatureData();
    P_Provider.getExtraIteamsData();
    P_Provider.getFeatureHomeData();
    P_Provider.getExtraHomeData();
    C_Provider.getKeyboardIcontData();
    C_Provider.getMonitorIcontData();
    C_Provider.getHeadSetIconData();
    P_Provider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    C_Provider = Provider.of<CategoryLinker>(context);
    P_Provider = Provider.of<ProductLinker>(context);
    getCallAllFunction();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),

      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(color:Colors.black,),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.greenAccent[700],
        leading: IconButton(icon:Icon(Icons.menu,color: Colors.black,),
            onPressed: (){
              _key.currentState.openDrawer();
            }
        ),
        actions: [
          IconButton(icon: Icon(Icons.search,color: Colors.black),
              onPressed:(){

              }),
          IconButton(icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black),
              onPressed:(){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => CartPage()));
              } ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _ImageSlider(),
                  _buildCategory(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildFeature(),
                  _ExtraItem(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
