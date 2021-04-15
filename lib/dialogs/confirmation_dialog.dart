
import 'package:flutter/material.dart';

confirmDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Padding(
          padding: EdgeInsets.only(left: 1 ,top: 10),
          child: Text('Delete post?'),
        ),
        content: Text('are you sure you want to delete this post ?',style: TextStyle(fontSize: 20,color: Colors.grey),),
        actions: <Widget>[

          FlatButton(
            child: const Text('DELETE',),
            onPressed: () {

            },
          ),FlatButton(
            child: const Text('CANCEL',style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}