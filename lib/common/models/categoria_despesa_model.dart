import 'package:despesas/common/database/app_db.dart';

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

  CategoriaModel.fromData(CategoriaData categoriaData) {
    id = categoriaData.id;
    descricao = categoriaData.descricao;
  }

  CategoriaData toData() {
    return CategoriaData(
      id: id!,
      descricao: descricao,
    );
  }
}
