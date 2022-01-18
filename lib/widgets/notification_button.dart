
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import '../pagelink/product_linker.dart';

class NotificationButton extends StatefulWidget {
  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  ProductLinker P_Provider;
  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            actions: [
              FlatButton(
                child: Text("Clear Notification"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    P_Provider.notificationList.clear();
                  });
                },
              ),
              FlatButton(
                child: Text("Okey"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(P_Provider.notificationList.isNotEmpty
                      ? "Confrim Your Order"
                      : "No Iteams in Cart"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    P_Provider = Provider.of<ProductLinker>(context);
    return Badge(
      position: BadgePosition(bottom: 25, top: 8),
      badgeContent: Text(
        P_Provider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.orange,
      child: IconButton(
        icon: Icon(
          Icons.notifications_active,
          color: Colors.black,
        ),
        onPressed: () {
          myDialogBox(context);
        },
      ),
    );
  }
}
