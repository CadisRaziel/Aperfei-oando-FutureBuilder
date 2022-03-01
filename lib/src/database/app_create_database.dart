import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDataBase() async {
  final String dbPath = await getDatabasesPath();
  final String pathzin = join(dbPath, 'bytebank.db');
  return openDatabase(
    pathzin,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'account_number INTEGER)',
      );
    },
    version: 1,
  );

  //TODO Abaixo usamos then acima usamos Async/await
  //TODO Diferença entre utlizar asyn/await e then
  //! getDatabasesPath -> ele retorna um future por isso precisamos por o 'then'
  // return getDatabasesPath().then((dbPath) {
  //! join -> arquivo que cria o database(dependendo do sistema aque esta operando ele vai fazer a junção que é compativel com o file system)
  //   final String pathzin = join(dbPath, 'bytebank.db');

  //! openDataBase -> função que abre o database
  //   return openDatabase(
  //     pathzin,
  //     onCreate: (db, version) {
  //! criando a tabela no sqflite
  //       db.execute(
  //         'CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)',
  //       );
  //     },
  //! versões da database conforme for mudando ela
  //     version: 1,
  //! limpando o database(pra isso atualize a versão, estava na '1' agora esta na '2' por conta desse onDownGrade)
  //! depois que voce colocou a versão 2 e foi no app e entro no campo aonde ta os dados, volte aqui e volte para a  versão 1 e pronto vai ta limpo e depois comente o onDownGrade
  //!  onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });
}
