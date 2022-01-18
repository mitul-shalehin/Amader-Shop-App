import 'dart:math';
import 'package:amadershop/model/categoryicons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryLinker with ChangeNotifier{

  List<Product> Mouse = [];
  Product MouseData;
  List<Product> Keyboard = [];
  Product KeyboardData;
  List<Product> Monitor = [];
  Product MonitorData;
  List<Product> HeadSet = [];
  Product HeadSetData;
  List<Product> Laptop = [];
  Product LaptopData;

  List <CategoryIcons> MouseIcon=[];
  CategoryIcons MouseIconData;


  Future<void> getMouseIconData() async {
    List<CategoryIcons> newList = [];
    QuerySnapshot MouseIconSnapShot = await FirebaseFirestore.instance
        .collection("catagoryicons")
        .doc("dCEnI847dc2Aas5MNnkG")
        .collection("Mouseicons")
        .get();
    MouseIconSnapShot.docs.forEach(
          (element) {
            MouseIconData = CategoryIcons(
                image: element.data()["image"]);
        newList.add(MouseIconData);
      },
    );
    MouseIcon = newList;
    notifyListeners();
  }

  List<CategoryIcons> get getMouseIcon {
    return MouseIcon;
  }

  List <CategoryIcons> HeadSetIcon=[];
  CategoryIcons HeadSetIconData;

  Future<void> getHeadSetIconData() async {
    List<CategoryIcons> newList = [];
    QuerySnapshot HeadSetIconSnapShot = await FirebaseFirestore.instance
        .collection("catagoryicons")
        .doc("dCEnI847dc2Aas5MNnkG")
        .collection("HeadSeticons")
        .get();
    HeadSetIconSnapShot.docs.forEach(
          (element) {
            HeadSetIconData = CategoryIcons(image: element.data()["image"]);
        newList.add(HeadSetIconData);
      },
    );
    HeadSetIcon = newList;
    notifyListeners();
  }

  List<CategoryIcons> get getHeadSetIcon {
    return HeadSetIcon;
  }




  List <CategoryIcons> KeyboardIcon=[];
  CategoryIcons KeyboardIconData;


  Future<void> getKeyboardIcontData() async {
    List<CategoryIcons> newList = [];
    QuerySnapshot KeyboardIconSnapShot = await FirebaseFirestore.instance
        .collection("catagoryicons")
        .doc("dCEnI847dc2Aas5MNnkG")
        .collection("Keybroadicons")
        .get();
    KeyboardIconSnapShot.docs.forEach(
          (element) {
            KeyboardIconData = CategoryIcons(image: element.data()["image"]);
        newList.add(KeyboardIconData);
      },
    );
    KeyboardIcon = newList;
    notifyListeners();
  }

  List<CategoryIcons> get getKeyboardIcon {
    return KeyboardIcon;
  }

  List <CategoryIcons> MonitorIcon=[];
  CategoryIcons MonitorIconData;


  Future<void> getMonitorIcontData() async {
    List<CategoryIcons> newList = [];
    QuerySnapshot MonitorIconSnapShot = await FirebaseFirestore.instance
        .collection("catagoryicons")
        .doc("dCEnI847dc2Aas5MNnkG")
        .collection("Monitoricons")
        .get();
    MonitorIconSnapShot.docs.forEach(
          (element) {
            MonitorIconData = CategoryIcons(image: element.data()["image"]);
        newList.add(MonitorIconData);
      },
    );
    MonitorIcon = newList;
    notifyListeners();
  }

  List<CategoryIcons> get getMonitorIcon {
    return MonitorIcon;
  }

  List <CategoryIcons> LaptopIcon=[];
  CategoryIcons LaptopIconData;


  Future<void> getLaptopIcontData() async {
    List<CategoryIcons> newList = [];
    QuerySnapshot LaptopIconSnapShot = await FirebaseFirestore.instance
        .collection("catagoryicons")
        .doc("dCEnI847dc2Aas5MNnkG")
        .collection("Laptopicons")
        .get();
    LaptopIconSnapShot.docs.forEach(
          (element) {
            LaptopIconData = CategoryIcons(image: element.data()["image"]);
        newList.add(LaptopIconData);
      },
    );
    LaptopIcon = newList;
    notifyListeners();
  }

  List<CategoryIcons> get getLaptopIcon {
    return LaptopIcon;
  }

  Future<void> getMouseData() async {
    List<Product> newList = [];
    QuerySnapshot MouseSnapShot = await FirebaseFirestore.instance
        .collection("catergory")
        .doc("bFZ47g0P3UPhNUQWupvw")
        .collection("mouse")
        .get();
    MouseSnapShot.docs.forEach(
          (element) {
        MouseData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(MouseData);
      },
    );
    Mouse= newList;
  }
  List<Product> get getMouseList{
    return Mouse;
  }

  Future<void> getKeyboardData() async {
    List<Product> newList = [];
    QuerySnapshot KeyboardSnapShot = await FirebaseFirestore.instance
        .collection("catergory")
        .doc("bFZ47g0P3UPhNUQWupvw")
        .collection("keyboard")
        .get();
    KeyboardSnapShot.docs.forEach(
          (element) {
            KeyboardData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(KeyboardData);
      },
    );
    Keyboard= newList;
  }
  List<Product> get getKeyboardList{
    return Keyboard;
  }

  Future<void> getMonitorData() async {
    List<Product> newList = [];
    QuerySnapshot MonitorSnapshot = await FirebaseFirestore.instance
        .collection("catergory")
        .doc("bFZ47g0P3UPhNUQWupvw")
        .collection("monitor")
        .get();
    MonitorSnapshot.docs.forEach(
          (element) {
            MonitorData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(MonitorData);
      },
    );
    Monitor= newList;
  }
  List<Product> get getMonitorList{
    return Monitor;
  }

  Future<void> getHeadSetData() async {
    List<Product> newList = [];
    QuerySnapshot HeadsetSnapShot = await FirebaseFirestore.instance
        .collection("catergory")
        .doc("bFZ47g0P3UPhNUQWupvw")
        .collection("headset")
        .get();
    HeadsetSnapShot.docs.forEach(
          (element) {
            HeadSetData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(HeadSetData);
      },
    );
    HeadSet= newList;
  }
  List<Product> get getHeadSetList{
    return HeadSet;
  }


  List<Product> searchList;

  void getSearchList({List<Product> list}) {
    searchList = list;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchitems = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchitems;
  }




}