import './pagelink/catagory_linker.dart';
import './pagelink/product_linker.dart';
import './screen/homepage.dart';
import './screen/welcompage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryLinker>(
          create: (context) => CategoryLinker(),
        ),
        ChangeNotifierProvider<ProductLinker>(
          create: (context) => ProductLinker(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.greenAccent[700],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}
