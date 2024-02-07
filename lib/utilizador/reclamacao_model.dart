class ReclamacaoModel {
  String area;
  String item;

  ReclamacaoModel({
    required this.area,
    required this.item,
  });

  //Metodo para converter um mapa em um objeto ReclamacaoModel
  factory ReclamacaoModel.fromMap(Map<String, dynamic> map) {
    return ReclamacaoModel(
      area: map['area'],
      item: map['problema'],
    );
  }

  //Metodo para converter um objeto ReclamacaoModel em um mapa
  Map<String, dynamic> toMap() {
    return {
      'area': area,
      'problema': item,
    };
  }
}
