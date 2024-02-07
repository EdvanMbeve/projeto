// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'telas/login_page.dart';
import 'utilizador/reclamacao_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReclamacaoProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
