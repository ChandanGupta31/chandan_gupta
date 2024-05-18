import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/firebase_data.dart';

class HomeProjectItem extends StatelessWidget {
  int index;
  HomeProjectItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await launchUrl(
          Uri.parse(FirebaseData.projects[index]['url']),
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch url');
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                FirebaseData.projects[index]['image_url'],
                height: MediaQuery.of(context).size.height * 0.12 >
                        MediaQuery.of(context).size.width * 0.12
                    ? MediaQuery.of(context).size.height * 0.12
                    : MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.height * 0.12 >
                        MediaQuery.of(context).size.width * 0.12
                    ? MediaQuery.of(context).size.height * 0.12
                    : MediaQuery.of(context).size.width * 0.12,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.175 >
                          MediaQuery.of(context).size.width * 0.175
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Text(
                      FirebaseData.projects[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.175 >
                          MediaQuery.of(context).size.width * 0.175
                      ? MediaQuery.of(context).size.width * 0.25
                      : MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    FirebaseData.projects[index]['description'],
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
