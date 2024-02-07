import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilizador/reclamacao_model.dart';
import '../utilizador/reclamacao_provider.dart';

class AdmPage extends StatefulWidget {
  @override
  _AdmPageState createState() => _AdmPageState();
}

class _AdmPageState extends State<AdmPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página do Administrador'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                Provider.of<ReclamacaoProvider>(context, listen: false).search(value);
              },
              decoration: InputDecoration(
                labelText: 'Buscar por nome da sala',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ReclamacaoProvider>(
              builder: (context, reclamacaoProvider, _) {
                List<ReclamacaoModel> reclamacoes = reclamacaoProvider.reclamacoes;

                if (reclamacoes.isEmpty) {
                  return Center(
                    child: Text('Nenhuma reclamacao encontrada.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: reclamacoes.length,
                    itemBuilder: (context, index) {
                      var reclamacao = reclamacoes[index];
                      return ListTile(
                        title: Text('Área: ${reclamacao.area}'),
                        subtitle: Text('Item: ${reclamacao.item}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //Remove a reclamacao da lista
                            reclamacaoProvider.removerReclamacao(reclamacao);
                            //Exibe uma mensagem de confirmacao
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Reclamacao removida com sucesso!'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
