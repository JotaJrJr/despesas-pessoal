class CategoriaModel {
  String? id;
  String? descricao;

  CategoriaModel({this.id, this.descricao});

  CategoriaModel.fromJson(Map<String, dynamic> json) {
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
