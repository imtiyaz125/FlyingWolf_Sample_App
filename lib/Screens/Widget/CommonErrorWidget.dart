import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonErrorWidget extends StatelessWidget {
  String errorMsg=StringConstants.GENERAL_NETWOR_ERROR_MESSAGE;

  CommonErrorWidget(this.errorMsg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error, size: 40, color: Colors.red,),
          SizedBox(height: 10,),
          Text(errorMsg,style: TextStyle(color: Colors.red,fontSize: 16),),
        ],
      ),
    );
  }

}