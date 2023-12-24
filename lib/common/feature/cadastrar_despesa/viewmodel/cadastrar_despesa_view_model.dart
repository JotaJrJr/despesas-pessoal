import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CadastrarDespesaViewModel extends ChangeNotifier {
  final ServiceDespesaImpl serviceDespesaImpl;
  final ServiceCategoriaImpl serviceCategoriaImpl;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CadastrarDespesaViewModel({
    required this.serviceDespesaImpl,
    required this.serviceCategoriaImpl,
  });

  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController categoriaDescricaoController = TextEditingController();

  List<DespesaModel> despesas = [];

  CategoriaModel? categoriaSelecionada;

  bool isCategoriaSelecionada = false;

  void preencherCategoriaSelecionada(CategoriaModel model) {
    categoriaSelecionada = model;
    isCategoriaSelecionada = true;
    notifyListeners();
  }

  void esvaziarCategoriaSelecionada() {
    categoriaSelecionada = null;
    isCategoriaSelecionada = false;
    notifyListeners();
  }

  Future<List<DespesaModel>> getAllDespesas() {
    return serviceDespesaImpl.getDespesas();
  }

  Stream<List<CategoriaModel>> watchAll() {
    return serviceCategoriaImpl.watchAll();
  }

  DespesaModel createModel() {
    String idDespesa = Uuid().v4();

    DespesaModel model = DespesaModel(
        id: idDespesa,
        descricao: descricaoController.text,
        valor: extractNumericValue(valorController.text),
        idCategoria: categoriaSelecionada?.id,
        descricaoCategoria: categoriaSelecionada?.descricao,
        data: DateTime.now().millisecondsSinceEpoch);

    debugPrint(model.toString());
    debugPrint(model.descricao);
    debugPrint(model.id);
    debugPrint(model.valor.toString());

    return model;
  }

  Future<void> saveDespesaToFirestore(DespesaModel model) async {
    try {
      final Map<String, dynamic> despesaMap = model.toJson();

      // await firestore.collection('despesas').doc(model.id!).collection('despesas').add(model.toJson());
      // await firestore.collection('despesas').doc(model.id!).set(model.toJson());

      await firestore.collection('despesas').add({
        'id': "12j301923j1",
        'descricao': "descrição foda",
        'valor': 12.3,
        'idCategoria': "1",
      });
    } catch (e) {
      debugPrint("deu erro aqui: $e");
      debugPrint(e.toString());
    }
  }

  bool canSaveCategoria() {
    if (categoriaDescricaoController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> insertCategoria() async {
    try {
      CategoriaModel model = CategoriaModel(
        id: const Uuid().v4(),
        descricao: categoriaDescricaoController.text,
      );

      await serviceCategoriaImpl.createCategoria(model);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> insertDespesa(DespesaModel model) async {
    await serviceDespesaImpl.createDespesa(model);
  }

  void deleteCategoriaById(String id) {
    serviceCategoriaImpl.deleteCategoria(id);
  }

  bool canSave() {
    return descricaoController.text.isNotEmpty && valorController.text.isNotEmpty;
  }

  double extractNumericValue(String text) {
    String cleanedText = text.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(',', '.');

    try {
      return double.parse(cleanedText);
    } catch (e) {
      debugPrint("Error parsing numeric value: $e");
      return 0.0;
    }
  }
}
