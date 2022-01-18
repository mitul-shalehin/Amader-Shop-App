import 'package:flutter/services.dart';
import '../screen/homepage.dart';
import 'package:flutter/material.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
        color: isActive ? Colors.greenAccent[700] : Colors.grey,
        borderRadius: BorderRadius.all(
            Radius.circular(12)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us",
          style:
          TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[700],
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.keyboard_backspace,color: Colors.black,),
          onPressed:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx)=>HomePage(),
            ),
            );
          },
        ),
      ),

      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 550,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image (image: AssetImage("images/1.jpg")),

                            ),
                            SizedBox(
                                height: 30
                            ),
                            Text('Search! \n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),

                            SizedBox(
                                height: 15
                            ),
                            Text('Search for your desired products in a well sorted order. In our website all the products are arranged in such a way that you all be able to navigate without a hitch.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                height: 1.2,),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image (image: AssetImage("images/2.jpg")),

                            ),
                            SizedBox(
                                height: 30
                            ),
                            Text('Order! \n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                height: 15
                            ),
                            Text("Order from anywhere around the world. You all not need to visit our shop for buying the product. Why so much fuss? When you can just order online!",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                height: 1.2,),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image (image: AssetImage("images/3.jpg")),

                            ),
                            SizedBox
                              (height: 30.0
                            ),
                            Text("Get it!\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),

                            SizedBox(
                                height: 10
                            ),
                            Text("Our shop always gives guarantee of the products and always ensures that our valued customers face no trouble about the authenticity of the products. Our products are delivered to us from genuine suppliers.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                height: 1.2,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
