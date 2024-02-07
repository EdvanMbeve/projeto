import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilizador/reclamacao_model.dart';
import '../utilizador/reclamacao_provider.dart';

class ProblemasPage extends StatelessWidget {
  final String area;

  ProblemasPage({required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problemas - $area'),
      ),
      body: Consumer<ReclamacaoProvider>(
        builder: (context, reclamacaoProvider, _) {
          List<ReclamacaoModel> problemas = reclamacaoProvider.reclamacoes.where((reclamacao) => reclamacao.area == area).toList();

          if (problemas.isEmpty) {
            return Center(
              child: Text('Nenhum problema registrado para esta sala.'),
            );
          } else {
            return ListView.builder(
              itemCount: problemas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(problemas[index].item),
                );
              },
            );
          }
        },
      ),
    );
  }
}
