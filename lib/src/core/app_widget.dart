import 'package:alura_sqlite/src/dashboard/home/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqlite',
      theme: ThemeData(
        primaryColor: Colors.green[900],

        //todos botões terão essa cor
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.blueAccent[700]),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
