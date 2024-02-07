import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilizador/reclamacao.dart';
import 'reclamacao_page.dart';
import 'adm_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images.jpeg'),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

void login() async {
  // Verificar as credenciais
  if (usernameController.text == "edvan" && passwordController.text == "1234") {
    // Salvar a informação de login usando SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);

    // Navegar para a tela de reclamação
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ReclamacaoPage(username: '',)),
    );
  } else if (usernameController.text == "adm" && passwordController.text == "0000") {
    // Se o usuário for "adm" e a senha for "0000", navegue para a tela de Adm
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdmPage()),
    );
  } else {
    // Exibir uma mensagem de erro se as credenciais estiverem incorretas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Credenciais incorretas')),
    );
  }
}
}
