import 'package:flutter/material.dart';

class AgradecimentoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agradecimento'),
      ),
      body: Center(
        child: Text(
          'Obrigado por reportar!\nTentaremos resolver o seu problema assim que possível.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
