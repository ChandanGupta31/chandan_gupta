import 'package:chandan_gupta/web/project/project_item.dart';
import 'package:flutter/material.dart';

import '../../utils/firebase_data.dart';

class ProjectWeb extends StatelessWidget {
  ProjectWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffceeeee),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: MediaQuery.of(context).size.width*0.03,
          ),
          itemCount: FirebaseData.projects.length,
          itemBuilder: (context, index){
            return projectItem(context, FirebaseData.projects[index]);
          },
        ),
      ),
    );
  }
}
