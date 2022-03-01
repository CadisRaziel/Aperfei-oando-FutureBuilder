import 'package:alura_sqlite/src/database/controller/controller_db.dart';
import 'package:alura_sqlite/src/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final ControllerDb _dbController = ControllerDb();
  final TextEditingController _nameCompletController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCompletController,
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
              ),
              style: const TextStyle(fontSize: 24),
              keyboardType: TextInputType.name,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                style: const TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                width: double.maxFinite,
                height: 40,
                color: Colors.blue,
                child: ElevatedButton(
                  onPressed: () {
                    final String nameString = _nameCompletController.text;
                    final int numberInt = int.parse(_numberController.text);

                    final Contact newContact =
                        Contact(name: nameString, number: numberInt, id: 0);

                    //salvando o contato no banco
                    _dbController
                        .save(newContact)
                        .then((id) => Navigator.pop(context));
                  },
                  child: const Text('Criar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
