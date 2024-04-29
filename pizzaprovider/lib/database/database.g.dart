// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorCistellaPizzaProviderDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CistellaPizzaProviderDBBuilder databaseBuilder(String name) =>
      _$CistellaPizzaProviderDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$CistellaPizzaProviderDBBuilder inMemoryDatabaseBuilder() =>
      _$CistellaPizzaProviderDBBuilder(null);
}

class _$CistellaPizzaProviderDBBuilder {
  _$CistellaPizzaProviderDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$CistellaPizzaProviderDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$CistellaPizzaProviderDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<CistellaPizzaProviderDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CistellaPizzaProviderDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CistellaPizzaProviderDB extends CistellaPizzaProviderDB {
  _$CistellaPizzaProviderDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CistellaDao? _cistellaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cistella` (`id` TEXT NOT NULL, `quantitat` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CistellaDao get cistellaDao {
    return _cistellaDaoInstance ??= _$CistellaDao(database, changeListener);
  }
}

class _$CistellaDao extends CistellaDao {
  _$CistellaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _cistellaInsertionAdapter = InsertionAdapter(
            database,
            'Cistella',
            (Cistella item) =>
                <String, Object?>{'id': item.id, 'quantitat': item.quantitat},
            changeListener),
        _cistellaUpdateAdapter = UpdateAdapter(
            database,
            'Cistella',
            ['id'],
            (Cistella item) =>
                <String, Object?>{'id': item.id, 'quantitat': item.quantitat},
            changeListener),
        _cistellaDeletionAdapter = DeletionAdapter(
            database,
            'Cistella',
            ['id'],
            (Cistella item) =>
                <String, Object?>{'id': item.id, 'quantitat': item.quantitat},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cistella> _cistellaInsertionAdapter;

  final UpdateAdapter<Cistella> _cistellaUpdateAdapter;

  final DeletionAdapter<Cistella> _cistellaDeletionAdapter;

  @override
  Stream<List<Cistella>> findAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Cistella',
        mapper: (Map<String, Object?> row) => Cistella(
            id: row['id'] as String, quantitat: row['quantitat'] as int),
        queryableName: 'Cistella',
        isView: false);
  }

  @override
  Future<void> insertFilaProducte(Cistella cistella) async {
    await _cistellaInsertionAdapter.insert(cistella, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFilaProducte(Cistella cistella) async {
    await _cistellaUpdateAdapter.update(cistella, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFilaProducte(Cistella cistella) async {
    await _cistellaDeletionAdapter.delete(cistella);
  }
}
