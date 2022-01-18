import 'package:amadershop/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/cartmodel.dart';
import 'package:flutter/material.dart';
import '../model/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductLinker with ChangeNotifier{

  List <Product> Feature = [];
  Product FeatureData;

  List <CartModel> checkOutModelList= [];
  CartModel checkOutModel;

  List<UserModel> userModelList = [];
  UserModel userModel;
  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
    await FirebaseFirestore.instance.collection("User").get();
    userSnapShot.docs.forEach(
          (element) {
        if (currentUser.uid == element.data()["UserId"]) {
          userModel = UserModel(
              userAddress: element.data()["UserAddress"],
              userImage: element.data()["UserImage"],
              userEmail: element.data()["UserEmail"],
              userGender: element.data()["UserGender"],
              userName: element.data()["UserName"],
              userPhoneNumber: element.data()["UserNumber"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }
  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void getCheckOutData({
    String image,
    String name,
    int price,
    int quentity,


  }) {
    checkOutModel = CartModel(
      name: name,
      price: price,
      image: image,
      quentity: quentity,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }


  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot FeatureSnapShot = await FirebaseFirestore.instance
        .collection("Products")
        .doc("No0brx7uMYLOOKkBm9eH")
        .collection("featureproducts")
        .get();
    FeatureSnapShot.docs.forEach(
          (element) {
            FeatureData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(FeatureData);
      },
    );
    Feature= newList;
  }
  List<Product> get getFeatureList{
    return Feature;
  }

  List <Product> FeatureHome = [];
  Product FeatureHomeData;
  Future<void> getFeatureHomeData() async {
    List<Product> newList = [];
    QuerySnapshot FeatureHomeSnapShot = await FirebaseFirestore.instance
        .collection("homefeature")
        .get();
    FeatureHomeSnapShot.docs.forEach(
          (element) {
        FeatureHomeData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(FeatureHomeData);
      },
    );
    FeatureHome= newList;
  }
  List<Product> get getFeatureHomeList{
    return FeatureHome;
  }

  List <Product> ExtraHome = [];
  Product ExtraHomeData;
  Future<void> getExtraHomeData() async {
    List<Product> newList = [];
    QuerySnapshot ExtraHomeSnapShot = await FirebaseFirestore.instance
        .collection("homeextraitem")
        .get();
    ExtraHomeSnapShot.docs.forEach(
          (element) {
        ExtraHomeData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(ExtraHomeData);
      },
    );
    ExtraHome= newList;
  }
  List<Product> get getExtraHomeList{
    return ExtraHome;
  }

  List <Product> ExtraIteams = [];
  Product ExtraIteamsData;
  Future<void> getExtraIteamsData() async {
    List<Product> newList = [];
    QuerySnapshot ExtraIteamsSnapShot = await FirebaseFirestore.instance
        .collection("Products")
        .doc("No0brx7uMYLOOKkBm9eH")
        .collection("extraitems")
        .get();
    ExtraIteamsSnapShot.docs.forEach(
          (element) {
            ExtraIteamsData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(ExtraIteamsData);
      },
    );
    ExtraIteams= newList;
  }
  List<Product> get getExtraIteamsList{
    return ExtraIteams;
  }
  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  List<Product> searchList;
  void getSearchList({List<Product> list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchitems = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchitems;
  }






}
