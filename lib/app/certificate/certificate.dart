import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/firebase_data.dart';

class CertificateApp extends StatelessWidget {
  CertificateApp({super.key});

  Future<void> viewCertificate(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: MediaQuery.of(context).size.width*0.03,
          ),
          itemCount: FirebaseData.certificates.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: () async {
                await viewCertificate(FirebaseData.certificates[index]);
              },
              child: Image.network(
                FirebaseData.certificates[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
