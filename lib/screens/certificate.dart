import 'package:chandan_gupta/services/firebase_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateScreen extends StatefulWidget {
  CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {

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
      body: Container(
        height: MediaQuery.of(context).size.height*0.9,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: MediaQuery.of(context).size.width*0.03,
          ),
          itemCount: FirebaseData.certificateList.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: () async {
                await viewCertificate(FirebaseData.certificateList[index]);
              },
              child: Image.network(
                FirebaseData.certificateList[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
