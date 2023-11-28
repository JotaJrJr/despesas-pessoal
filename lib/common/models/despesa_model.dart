class DespesaModel {
  int? id;
  String? descricao;
  double? valor;
  int? data;
  int? idCategoria;
  int? sincronizado;

  DespesaModel({this.id, this.descricao, this.valor, this.data, this.idCategoria, this.sincronizado});

  DespesaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valor = json['valor'];
    data = json['data'];
    idCategoria = json['idCategoria'];
    sincronizado = json['sincronizado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['descricao'] = descricao;
    data['valor'] = valor;
    data['data'] = data;
    data['idCategoria'] = idCategoria;
    data['sincronizado'] = sincronizado;
    return data;
  }
}
