import 'package:alura_sqlite/src/database/app_create_database.dart';
import 'package:alura_sqlite/src/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ControllerDb {
  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.number;
    return contactMap;
  }

  //salvando contato
  Future<int> save(Contact contact) async {
    final Database db = await createDataBase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert('contacts', contactMap);

//TODO Abaixo usamos then acima usamos Async/await
//TODO Diferença entre utlizar asyn/await e then
    //! para termos acesso ao then do createDataBase precisamos retornar o then na função de cima
    // return createDataBase().then((db) {
    //   final Map<String, dynamic> contactMap = {};
    //! chave dados do sqflite, valor dados do model
    //! retiramos o id porque o sqlite que vai ser resposavel por incrementar o id automaticamente e não nós
    //! contactMap['id'] = contact.id;
    //   contactMap['name'] = contact.name;
    //   contactMap['account_number'] = contact.number;
    //   return db.insert('contacts', contactMap);
    // });
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        id: row['id'],
        name: row['name'],
        number: row['account_number'],
      );

      //a gente vare usando map e adiciona na lista de contato
      contacts.add(contact);
    }
    return contacts;
  }

  Future<List<Contact>> findAll() async {
    //!quando tiver duvida do tipo do retorno, coloque um .then e veja o que ele espera
//final List<Map<String, dynamic>> result = await db.query('contacts').then;

    final Database db = await createDataBase();
    final List<Map<String, dynamic>> result = await db.query('contacts');
    List<Contact> contacts = _toList(result);
    return contacts;

    //TODO Abaixo usamos then acima usamos Async/await
    //TODO Diferença entre utlizar asyn/await e then
    // return createDataBase().then((db) {
    //   return db.query('contacts').then((maps) {
    //     final List<Contact> contacts = [];
    //     for (Map<String, dynamic> map in maps) {
    //       final Contact contact = Contact(
    //         id: map['id'],
    //         name: map['name'],
    //         number: map['account_number'],
    //       );

    //       //a gente vare usando map e adiciona na lista de contato
    //       contacts.add(contact);
    //     }
    //     return contacts;
    // });
    // });
  }
}
