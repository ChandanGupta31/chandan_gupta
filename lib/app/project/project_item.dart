import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget projectItem(BuildContext context, Map<String, dynamic> data){
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: -1,
          blurRadius: 4,
          offset: Offset(3, 3),
        )
      ],
    ),
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            data['image_url'],
            height: MediaQuery.of(context).size.height*0.15,
            width: MediaQuery.of(context).size.height*0.15,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            child: Text(
              data['name'],
              style: TextStyle(
                fontFamily: 'BlackOps',
                fontSize: 21,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Text(
            data['description'],
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
        Spacer(),
        Container(
          child: ElevatedButton(
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(data['url']),
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch url');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View On',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'BlackOps',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Image.asset(
                  data['view_on']=='play_store' ? 'assets/images/playstore.png' : 'assets/images/github.png',
                  height: MediaQuery.of(context).size.height*0.03,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    ),
  );
}