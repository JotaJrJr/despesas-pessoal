class CategoriaDespesaModel {
  int? id;
  String? descricao;

  CategoriaDespesaModel({this.id, this.descricao});

  CategoriaDespesaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['descricao'] = descricao;
    return data;
  }
}
