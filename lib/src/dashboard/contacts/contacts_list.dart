import 'package:alura_sqlite/src/dashboard/contact_form/contact_form.dart';
import 'package:alura_sqlite/src/database/controller/controller_db.dart';
import 'package:alura_sqlite/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'components/contacts_items_component.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ControllerDb _dbController = ControllerDb();
  @override
  Widget build(BuildContext context) {
    //testando pra ve se ta funcionando (quando tive vazio)
    // contacts.add(Contact(id: 0, name: 'Batman', number: 12132) );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      //Preciso tipar o FutureBuilder de acordo com a função que ira no 'future'
      body: FutureBuilder<List<Contact>>(
        //no future vai uma função Future criada para buscar dados (ou api ou database)
        future: _dbController.findAll(),
        // initialData -> ao invez de apresenta o circularProgress podemos iniciar uma lista vazia, ai quando tiver dado ele apresenta eles
        // initialData -> poderiamos tirar o if(snapshot.hasData) inclusive (porém é perigoso)
        // initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Contact> contacts = snapshot.data ?? [];
            //o return vai ser a apresentação dos dados na tela
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return ContactsItemsComponent(
                  contact: contact,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('Ops, parece que ocorreu um erro')],
            );
          }

          //retorne um circularProgressIndicator ou esse package maneiro (caso o futureBuidler não conseguir dados)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SpinKitPianoWave(
                color: Colors.green,
                size: 25,
              ),
              SizedBox(
                height: 15,
              ),
              Text('Carregando')
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ),
          );
          //Para mostrar no console os dados da outra tela (é tipo um print, porém pegando informações de outra tela)
          // .then(
          //   (newContact) => debugPrint(newContact.toString()),
          // );
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


//snapshot.connectionState == ConnectionState.none -> o Future ainda não foi executado, podemos colocar um widget que o usuario interaja esperando ser concluido o Furure(ou seja podemos incluir um botão para tipo 'clique aqui' e o Future começa rodar, usado pra coisas especificas)
//snapshot.connectionState == ConnectionState.waiting -> aguardando o Future a ser executado, sempre por um circularProgressIndicator
//snapshot.connectionState == ConnectionState.active -> o nosso snapshot tem um dado disponivel, só que ainda não foi finalizado o future (mais utilizado em downloads, pois traz em pedaços o progresso exemplo: fez 20% do download, ele nos traz esse progresso 'usado mais com stream')
//snapshot.connectionState == ConnectionState.done -> retorna o dado a ser apresentado


//Poderia fazer assim o FutureBuilder

  //  body: FutureBuilder<List<Contact>>(
  //       future = findAll(),
  //       builder = (context, snapshot) {
  //         switch (snapshot.connectionState) {
  //           case ConnectionState.waiting:
  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: const [
  //                 SpinKitPianoWave(
  //                   color: Colors.green,
  //                   size: 25,
  //                 ),
  //                 SizedBox(
  //                   height: 15,
  //                 ),
  //                 Text('Carregando')
  //               ],
  //             );
  //           case ConnectionState.done:
  //             final List<Contact> contacts = snapshot.data ?? [];
  //             //o return vai ser a apresentação dos dados na tela
  //             return ListView.builder(
  //               itemCount: contacts.length,
  //               itemBuilder: (context, index) {
  //                 final Contact contact = contacts[index];
  //                 return ContactsItemsComponent(
  //                   contact: contact,
  //                 );
  //               },
  //             );
  //         }
  //         // No return do switch retornariamos um erro
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: const [Text('Ops, parece que ocorreu um erro')],
  //         );
  //       },
  //     ),