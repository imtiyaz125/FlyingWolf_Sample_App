import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomeProfileScreen.dart';
import 'RecommendedTournamentScreen.dart';
import 'Widget/CustomToolbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CustomToolbar(StringConstants.APP_NAME),
            Container(
                height: MediaQuery.of(context).size.height / 4,
                child: HomeProfileScreen()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child: Text(
                StringConstants.RECOMMENDED_TITLE,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 3 / 4 - 150,
                child: RecommendedTournament())
          ],
        ),
      ),
    );
  }
}