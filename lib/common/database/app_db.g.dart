// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $DespesaTable extends Despesa with TableInfo<$DespesaTable, DespesaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DespesaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'ID', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'DESCRICAO', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'VALOR', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<int> data = GeneratedColumn<int>(
      'DATA', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idCategoriaMeta =
      const VerificationMeta('idCategoria');
  @override
  late final GeneratedColumn<String> idCategoria = GeneratedColumn<String>(
      'ID_CATEGORIA', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descricaoCategoriaMeta =
      const VerificationMeta('descricaoCategoria');
  @override
  late final GeneratedColumn<String> descricaoCategoria =
      GeneratedColumn<String>('DESCRICAO_CATEGORIA', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'SINCRONIZADO', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("SINCRONIZADO" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        descricao,
        valor,
        data,
        idCategoria,
        descricaoCategoria,
        sincronizado
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'despesa';
  @override
  VerificationContext validateIntegrity(Insertable<DespesaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('DESCRICAO')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('VALOR')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    if (data.containsKey('DATA')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['DATA']!, _dataMeta));
    }
    if (data.containsKey('ID_CATEGORIA')) {
      context.handle(
          _idCategoriaMeta,
          idCategoria.isAcceptableOrUnknown(
              data['ID_CATEGORIA']!, _idCategoriaMeta));
    }
    if (data.containsKey('DESCRICAO_CATEGORIA')) {
      context.handle(
          _descricaoCategoriaMeta,
          descricaoCategoria.isAcceptableOrUnknown(
              data['DESCRICAO_CATEGORIA']!, _descricaoCategoriaMeta));
    }
    if (data.containsKey('SINCRONIZADO')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['SINCRONIZADO']!, _sincronizadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DespesaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DespesaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ID'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRICAO']),
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}VALOR']),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}DATA']),
      idCategoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ID_CATEGORIA']),
      descricaoCategoria: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}DESCRICAO_CATEGORIA']),
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}SINCRONIZADO']),
    );
  }

  @override
  $DespesaTable createAlias(String alias) {
    return $DespesaTable(attachedDatabase, alias);
  }
}

class DespesaData extends DataClass implements Insertable<DespesaData> {
  final String id;
  final String? descricao;
  final double? valor;
  final int? data;
  final String? idCategoria;
  final String? descricaoCategoria;
  final bool? sincronizado;
  const DespesaData(
      {required this.id,
      this.descricao,
      this.valor,
      this.data,
      this.idCategoria,
      this.descricaoCategoria,
      this.sincronizado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<String>(id);
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String>(descricao);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double>(valor);
    }
    if (!nullToAbsent || data != null) {
      map['DATA'] = Variable<int>(data);
    }
    if (!nullToAbsent || idCategoria != null) {
      map['ID_CATEGORIA'] = Variable<String>(idCategoria);
    }
    if (!nullToAbsent || descricaoCategoria != null) {
      map['DESCRICAO_CATEGORIA'] = Variable<String>(descricaoCategoria);
    }
    if (!nullToAbsent || sincronizado != null) {
      map['SINCRONIZADO'] = Variable<bool>(sincronizado);
    }
    return map;
  }

  DespesaCompanion toCompanion(bool nullToAbsent) {
    return DespesaCompanion(
      id: Value(id),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      valor:
          valor == null && nullToAbsent ? const Value.absent() : Value(valor),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      idCategoria: idCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(idCategoria),
      descricaoCategoria: descricaoCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(descricaoCategoria),
      sincronizado: sincronizado == null && nullToAbsent
          ? const Value.absent()
          : Value(sincronizado),
    );
  }

  factory DespesaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DespesaData(
      id: serializer.fromJson<String>(json['id']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      valor: serializer.fromJson<double?>(json['valor']),
      data: serializer.fromJson<int?>(json['data']),
      idCategoria: serializer.fromJson<String?>(json['idCategoria']),
      descricaoCategoria:
          serializer.fromJson<String?>(json['descricaoCategoria']),
      sincronizado: serializer.fromJson<bool?>(json['sincronizado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descricao': serializer.toJson<String?>(descricao),
      'valor': serializer.toJson<double?>(valor),
      'data': serializer.toJson<int?>(data),
      'idCategoria': serializer.toJson<String?>(idCategoria),
      'descricaoCategoria': serializer.toJson<String?>(descricaoCategoria),
      'sincronizado': serializer.toJson<bool?>(sincronizado),
    };
  }

  DespesaData copyWith(
          {String? id,
          Value<String?> descricao = const Value.absent(),
          Value<double?> valor = const Value.absent(),
          Value<int?> data = const Value.absent(),
          Value<String?> idCategoria = const Value.absent(),
          Value<String?> descricaoCategoria = const Value.absent(),
          Value<bool?> sincronizado = const Value.absent()}) =>
      DespesaData(
        id: id ?? this.id,
        descricao: descricao.present ? descricao.value : this.descricao,
        valor: valor.present ? valor.value : this.valor,
        data: data.present ? data.value : this.data,
        idCategoria: idCategoria.present ? idCategoria.value : this.idCategoria,
        descricaoCategoria: descricaoCategoria.present
            ? descricaoCategoria.value
            : this.descricaoCategoria,
        sincronizado:
            sincronizado.present ? sincronizado.value : this.sincronizado,
      );
  @override
  String toString() {
    return (StringBuffer('DespesaData(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('valor: $valor, ')
          ..write('data: $data, ')
          ..write('idCategoria: $idCategoria, ')
          ..write('descricaoCategoria: $descricaoCategoria, ')
          ..write('sincronizado: $sincronizado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao, valor, data, idCategoria,
      descricaoCategoria, sincronizado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DespesaData &&
          other.id == this.id &&
          other.descricao == this.descricao &&
          other.valor == this.valor &&
          other.data == this.data &&
          other.idCategoria == this.idCategoria &&
          other.descricaoCategoria == this.descricaoCategoria &&
          other.sincronizado == this.sincronizado);
}

class DespesaCompanion extends UpdateCompanion<DespesaData> {
  final Value<String> id;
  final Value<String?> descricao;
  final Value<double?> valor;
  final Value<int?> data;
  final Value<String?> idCategoria;
  final Value<String?> descricaoCategoria;
  final Value<bool?> sincronizado;
  final Value<int> rowid;
  const DespesaCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valor = const Value.absent(),
    this.data = const Value.absent(),
    this.idCategoria = const Value.absent(),
    this.descricaoCategoria = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DespesaCompanion.insert({
    required String id,
    this.descricao = const Value.absent(),
    this.valor = const Value.absent(),
    this.data = const Value.absent(),
    this.idCategoria = const Value.absent(),
    this.descricaoCategoria = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<DespesaData> custom({
    Expression<String>? id,
    Expression<String>? descricao,
    Expression<double>? valor,
    Expression<int>? data,
    Expression<String>? idCategoria,
    Expression<String>? descricaoCategoria,
    Expression<bool>? sincronizado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (descricao != null) 'DESCRICAO': descricao,
      if (valor != null) 'VALOR': valor,
      if (data != null) 'DATA': data,
      if (idCategoria != null) 'ID_CATEGORIA': idCategoria,
      if (descricaoCategoria != null) 'DESCRICAO_CATEGORIA': descricaoCategoria,
      if (sincronizado != null) 'SINCRONIZADO': sincronizado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DespesaCompanion copyWith(
      {Value<String>? id,
      Value<String?>? descricao,
      Value<double?>? valor,
      Value<int?>? data,
      Value<String?>? idCategoria,
      Value<String?>? descricaoCategoria,
      Value<bool?>? sincronizado,
      Value<int>? rowid}) {
    return DespesaCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      idCategoria: idCategoria ?? this.idCategoria,
      descricaoCategoria: descricaoCategoria ?? this.descricaoCategoria,
      sincronizado: sincronizado ?? this.sincronizado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<String>(id.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String>(descricao.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double>(valor.value);
    }
    if (data.present) {
      map['DATA'] = Variable<int>(data.value);
    }
    if (idCategoria.present) {
      map['ID_CATEGORIA'] = Variable<String>(idCategoria.value);
    }
    if (descricaoCategoria.present) {
      map['DESCRICAO_CATEGORIA'] = Variable<String>(descricaoCategoria.value);
    }
    if (sincronizado.present) {
      map['SINCRONIZADO'] = Variable<bool>(sincronizado.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DespesaCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('valor: $valor, ')
          ..write('data: $data, ')
          ..write('idCategoria: $idCategoria, ')
          ..write('descricaoCategoria: $descricaoCategoria, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriaTable extends Categoria
    with TableInfo<$CategoriaTable, CategoriaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'ID', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'DESCRICAO', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categoria';
  @override
  VerificationContext validateIntegrity(Insertable<CategoriaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('DESCRICAO')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CategoriaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ID'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRICAO']),
    );
  }

  @override
  $CategoriaTable createAlias(String alias) {
    return $CategoriaTable(attachedDatabase, alias);
  }
}

class CategoriaData extends DataClass implements Insertable<CategoriaData> {
  final String id;
  final String? descricao;
  const CategoriaData({required this.id, this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<String>(id);
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String>(descricao);
    }
    return map;
  }

  CategoriaCompanion toCompanion(bool nullToAbsent) {
    return CategoriaCompanion(
      id: Value(id),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
    );
  }

  factory CategoriaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriaData(
      id: serializer.fromJson<String>(json['id']),
      descricao: serializer.fromJson<String?>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  CategoriaData copyWith(
          {String? id, Value<String?> descricao = const Value.absent()}) =>
      CategoriaData(
        id: id ?? this.id,
        descricao: descricao.present ? descricao.value : this.descricao,
      );
  @override
  String toString() {
    return (StringBuffer('CategoriaData(')
          ..write('id: $id, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriaData &&
          other.id == this.id &&
          other.descricao == this.descricao);
}

class CategoriaCompanion extends UpdateCompanion<CategoriaData> {
  final Value<String> id;
  final Value<String?> descricao;
  final Value<int> rowid;
  const CategoriaCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriaCompanion.insert({
    required String id,
    this.descricao = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CategoriaData> custom({
    Expression<String>? id,
    Expression<String>? descricao,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (descricao != null) 'DESCRICAO': descricao,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriaCompanion copyWith(
      {Value<String>? id, Value<String?>? descricao, Value<int>? rowid}) {
    return CategoriaCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<String>(id.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String>(descricao.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $DespesaTable despesa = $DespesaTable(this);
  late final $CategoriaTable categoria = $CategoriaTable(this);
  late final DespesaDao despesaDao = DespesaDao(this as AppDb);
  late final CategoriaDao categoriaDao = CategoriaDao(this as AppDb);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [despesa, categoria];
}
