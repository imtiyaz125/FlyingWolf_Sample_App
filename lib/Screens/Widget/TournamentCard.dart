import 'package:cache_image/cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  String coverUrl;
  String name;
  String gameName;

  @override
  Widget build(BuildContext context) {
    return buildCardWidget(context);
  }

  TournamentCard({this.coverUrl, this.name, this.gameName});

  Widget buildCardWidget(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(top: 10,left: 16,right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            child: FadeInImage(
                fit: BoxFit.fitWidth,
                height: 75,
                width: MediaQuery.of(context).size.width,
                placeholder:CacheImage(coverUrl),
                image: CacheImage(coverUrl)),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/1.9,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              gameName,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
