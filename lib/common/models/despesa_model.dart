import 'package:despesas/common/database/app_db.dart';

class DespesaModel {
  String? id;
  String? descricao;
  double? valor;
  int? data;
  String? idCategoria;
  String? descricaoCategoria;
  bool? sincronizado;

  DespesaModel({this.id, this.descricao, this.valor, this.data, this.idCategoria, this.descricaoCategoria, this.sincronizado});

  DespesaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valor = json['valor'];
    data = json['data'];
    idCategoria = json['idCategoria'];
    descricaoCategoria = json['descricaoCategoria'];
    sincronizado = json['sincronizado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['descricao'] = descricao;
    data['valor'] = valor;
    data['data'] = data;
    data['idCategoria'] = idCategoria;
    data['descricaoCategoria'] = descricaoCategoria;
    data['sincronizado'] = sincronizado;
    return data;
  }

  DespesaModel.fromData(DespesaData despesaData) {
    id = despesaData.id;
    descricao = despesaData.descricao;
    valor = despesaData.valor;
    data = despesaData.data;
    idCategoria = despesaData.idCategoria;
    descricaoCategoria = despesaData.descricaoCategoria;
    sincronizado = despesaData.sincronizado;
  }

  DespesaData toData() {
    return DespesaData(
      id: id!,
      descricao: descricao,
      valor: valor,
      data: data,
      idCategoria: idCategoria,
      descricaoCategoria: descricaoCategoria,
      sincronizado: sincronizado,
    );
  }
}
