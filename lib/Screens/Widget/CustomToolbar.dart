import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomToolbar extends StatelessWidget {
  String title;

  CustomToolbar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 75,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.filter_list_sharp,
            size: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20,)
        ],
      ),
    );
  }
}
