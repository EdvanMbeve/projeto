import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reclamacao_model.dart';

class ReclamacaoProvider extends ChangeNotifier {
  List<ReclamacaoModel> _reclamacoes = [];
  List<ReclamacaoModel> _filteredReclamacoes = [];

  List<ReclamacaoModel> get reclamacoes => _filteredReclamacoes.isEmpty ? _reclamacoes : _filteredReclamacoes;

  ReclamacaoProvider() {
    _loadReclamacoes(); //Carrega reclamacoes salvas
  }

  //AAdd reclamacao
  void adicionarReclamacao(ReclamacaoModel reclamacao) {
    _reclamacoes.add(reclamacao);
    _saveReclamacoes();
    notifyListeners();
  }

  //Funcao de remover reclamacao
  void removerReclamacao(ReclamacaoModel reclamacao) {
    _reclamacoes.remove(reclamacao);
    _saveReclamacoes();
    notifyListeners();
  }

  //Salvar reclamacao nas SharedPreferences
  Future<void> _saveReclamacoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reclamacoesString =
        _reclamacoes.map((reclamacao) => json.encode(reclamacao.toMap())).toList();
    await prefs.setStringList('reclamacoes', reclamacoesString);
  }

  //Carregar reclamacao das SharedPreferences
  Future<void> _loadReclamacoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? reclamacoesString = prefs.getStringList('reclamacoes');
    if (reclamacoesString != null) {
      _reclamacoes = reclamacoesString
          .map((reclamacaoString) => ReclamacaoModel.fromMap(json.decode(reclamacaoString)))
          .toList();
      notifyListeners();
    }
  }

  //Funcao de pesquisar reclamacao por nome da sala
  void search(String query) {
    if (query.isEmpty) {
      _filteredReclamacoes = [];
    } else {
      _filteredReclamacoes = _reclamacoes
          .where((reclamacao) => reclamacao.area.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
