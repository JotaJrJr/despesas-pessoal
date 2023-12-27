import 'package:despesas/common/database/app_db.dart';

class DespesaModel {
  String? id;
  String? descricao;
  double? valor;
  int? data;
  String? idCategoria;
  String? descricaoCategoria;
  bool? sincronizado;
  int? perfil;

  DespesaModel({this.id, this.descricao, this.valor, this.data, this.idCategoria, this.descricaoCategoria, this.sincronizado, this.perfil});

  DespesaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valor = json['valor'];
    data = json['data'];
    idCategoria = json['idCategoria'];
    descricaoCategoria = json['descricaoCategoria'];
    sincronizado = json['sincronizado'];
    perfil = json['perfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> object = {};
    object['descricao'] = descricao;
    object['valor'] = valor;
    object['data'] = data;
    object['idCategoria'] = idCategoria;
    object['descricaoCategoria'] = descricaoCategoria;
    object['sincronizado'] = sincronizado;
    object['perfil'] = perfil;
    return object;
  }

  DespesaModel.fromData(DespesaData despesaData) {
    id = despesaData.id;
    descricao = despesaData.descricao;
    valor = despesaData.valor;
    data = despesaData.data;
    idCategoria = despesaData.idCategoria;
    descricaoCategoria = despesaData.descricaoCategoria;
    sincronizado = despesaData.sincronizado;
    perfil = despesaData.perfil;
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
      perfil: perfil,
    );
  }
}
