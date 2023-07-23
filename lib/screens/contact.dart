import 'package:flutter/material.dart';

import '../widgets/contact_column.dart';
import '../widgets/contact_row.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var nameController = TextEditingController();
  var contactController = TextEditingController();
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width <= 900 ? ContactColumn() : ContactRow(),
    );
  }
}
