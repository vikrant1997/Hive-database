import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/contact.dart';
import 'new_contact_form.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      // bottom: true,
      top: false,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Hive Tutorial'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(child: _buildListView()),
              NewContactForm(),
            ],
          )),
    );
  }

  ListView _buildListView() {
    final contactsBox = Hive.box('contacts');
    return ListView.builder(
        itemCount: contactsBox.length,
        itemBuilder: (context, index) {
          final contact = contactsBox.getAt(index) as Contact;
          return ListTile(
            title: Text('${contact.name}'),
            subtitle: Text('${contact.age}'),
          );
        });
  }
}
