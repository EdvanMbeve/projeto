import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilizador/reclamacao_model.dart';
import '../utilizador/reclamacao_provider.dart';
import 'adm_page.dart';

class ReclamacaoPage extends StatefulWidget {
  final String username;

  ReclamacaoPage({required this.username});

  @override
  _ReclamacaoPageState createState() => _ReclamacaoPageState();
}

class _ReclamacaoPageState extends State<ReclamacaoPage> {
  String? _selectedArea;
  String? _selectedItem;
  List<String> _areas = ['Sala de informática 1', 'Sala 114', 'LabTec'];
  List<String> _itens = ['Computador', 'Ar condicionado', 'Cameras'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reclamacao'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sr./Sra. ${widget.username},\nSeja bem-vindo(a) à página de reclamações do ISUTC',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedArea,
              onChanged: (newValue) {
                setState(() {
                  _selectedArea = newValue;
                });
              },
              items: _areas.map((area) {
                return DropdownMenuItem(
                  value: area,
                  child: Text(area),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Area',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedItem,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
              },
              items: _itens.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Problema',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //Confirma se as opcoes foram selecionadas
                if (_selectedArea != null && _selectedItem != null) {
                  //Verifica se jA existe uma reclamacao para a mesma area e problema
                  bool hasDuplicate = Provider.of<ReclamacaoProvider>(context, listen: false)
                      .reclamacoes
                      .any((reclamacao) =>
                          reclamacao.area == _selectedArea && reclamacao.item == _selectedItem);

                  if (hasDuplicate) {
                    //Caso exista uma reclamacao para a mesma area e problema, mostra uma mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Esta reclamacao ja foi registrada.'),
                      ),
                    );
                  } else {
                    //Caso contrario, cria uma reclamacao
                    ReclamacaoModel reclamacao = ReclamacaoModel(
                      area: _selectedArea!,
                      item: _selectedItem!,
                    );
                    //Envia a reclamacao para o sistema
                    Provider.of<ReclamacaoProvider>(context, listen: false)
                        .adicionarReclamacao(reclamacao);
                    //Salva as opcoes nas SharedPreferences
                    _savePreferences();
                    //Exibe uma mensagem de confirmacao
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reclamacao enviada com sucesso!'),
                      ),
                    );
                  }
                } else {
                  //Mostra uma mensagem de erro se as opcoes nao forem selecionadas
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, selecione uma area e um problema.'),
                    ),
                  );
                }
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedArea', _selectedArea ?? '');
    prefs.setString('selectedItem', _selectedItem ?? '');
  }
}
