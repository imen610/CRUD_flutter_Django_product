import 'package:crud/index.dart';
import 'package:flutter/material.dart';

showMessage(BuildContext context, String contentMessage) {
  // set up the buttons
  var primary;

  Widget yesButton = FlatButton(
    child: Text("ok", style: TextStyle(color: primary)),
    onPressed: () {
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => IndexPage()),
          (Route<dynamic> route) => false);
      // deleteUser(item['id']);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Message"),
    content: Text(contentMessage),
    actions: [
      yesButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
