import 'package:alura_sqlite/src/models/contact.dart';
import 'package:flutter/material.dart';

class ContactsItemsComponent extends StatelessWidget {
  final Contact contact;

  const ContactsItemsComponent({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name ?? '',
          style: const TextStyle(fontSize: 22),
        ),
        subtitle: Text(
          contact.number.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
