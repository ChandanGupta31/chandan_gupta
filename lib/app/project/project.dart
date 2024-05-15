import 'package:chandan_gupta/app/project/project_item.dart';
import 'package:chandan_gupta/utils/firebase_data.dart';
import 'package:flutter/material.dart';

class ProjectApp extends StatelessWidget {
  ProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 450,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
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
