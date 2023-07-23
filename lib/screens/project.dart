import 'package:chandan_gupta/widgets/project_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height*0.9,
        padding: EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
            .collection('projects')
            .snapshots(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 450,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    return projectItem(context, snapshot.data!.docs[index].data() as Map<String, dynamic>);
                  },
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
