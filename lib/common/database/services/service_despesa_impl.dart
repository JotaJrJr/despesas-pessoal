import 'dart:convert';
import 'dart:js_interop';

import 'package:despesas/common/domain/services/service_despesa.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ServiceDespesaImpl implements ServiceDespesa {
  static List<DespesaModel> listaDespesas = [];

  ServiceDespesaImpl() {}

  @override
  Future<int> createDespesa(DespesaModel model) async {
    model.id = const Uuid().v1().hashCode;

    // await
  }

  @override
  Future deleteDespesa(int id) async {
    var data = getDespesa(id);
    if (data == null) {
      return;
    }
    listaDespesas.removeWhere((element) => element.id == id);

    _updateList();
  }

  @override
  Future<DespesaModel> getDespesa(int id) {
    return Future.value(listaDespesas.firstWhere((element) => element.id == id));
  }

  @override
  Future<List<DespesaModel>> getDespesas() async {
    return listaDespesas;
  }

  @override
  Future<DespesaModel> updateDespesa(int id, DespesaModel model) async {
    await _saveOrUpdate(id, model);
    return model;
  }

  Future<void> _saveOrUpdate(int id, DespesaModel model) async {
    int index = listaDespesas.indexWhere((element) => element.id == id);

    if (index != -1) {
      listaDespesas[index] = model;
    } else {
      listaDespesas.add(model);
    }
  }

  Future<void> _updateList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('despesas', json.encode(listaDespesas.map((e) => e.toJson()).toList()));
  }

  void _fillDespesas() async {
    List<DespesaModel> despesas = [];

    if (listaDespesas.isNotEmpty) {
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final despesasData = prefs.getString('despesas');
    if (despesasData != null) {
      final List<dynamic> despesasList = json.decode(despesasData);
      despesas = despesasList.map((e) => DespesaModel.fromJson(e)).toList();
    }

    listaDespesas = despesas;
  }
}
