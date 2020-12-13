import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility{
  static Future<bool> checkNetwork() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    return false;
  }
  static void showAlertDialog(BuildContext context,String title,String message){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(title,style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),),
              SizedBox(height: 30,),
              Text(message,style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Okay',style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),),
              onPressed: () =>{
                Navigator.of(context).pop(),}
          ),
        ],
      ),
    );
  }
}