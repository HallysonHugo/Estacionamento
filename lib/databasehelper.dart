import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Estacionamento Table

const String estacionamentoTable = 'ESTACIONAMENTO';
const String vagaEstacionamento = 'NUMERO_VAGA';
const String vagaPreenchida = 'PREENCHIDA';
const String dataEntrada = 'DATA_ENTRADA';
const String dataSaida = 'DATA_SAIDA';

//Historico Table
const String historicoTable = 'HISTORICO';
const String idHistorico = 'ID';
const String vagaEstacionamentoHistorico = 'NUMERO_VAGA';
const String clienteHistorico = 'CLIENTE';
const String dataEntradaHistorico = 'DATA_ENTRADA';
const String dataSaidaHistorico = 'DATA_SAIDA';




class BancoDeDados{
  BancoDeDados._privateConstructor();
  static final BancoDeDados instance = BancoDeDados._privateConstructor();

  Database? db;

  /*Future<Database> get database async {    
    _database = await _initdatabase();
    // ignore: recursive_getters
    return database;
  }*/

  Future<Database>_initdatabase()async{
    String caminhoDoBanco = await getDatabasesPath();
    String _banco = 'Estacionamento.db';
    String path = join(caminhoDoBanco, _banco);
    return await openDatabase(path,version: 1, onCreate:criarBanco);
  }
  Future criarBanco (Database db, int novaVersao)async{
    List<String> queries = [
      """CREATE TABLE $estacionamentoTable($vagaEstacionamento INTEGER PRIMARY KEY,
      $vagaPreenchida INTEGER, $dataEntrada TEXT, $dataSaida TEXT)""",

      """CREATE TABLE $historicoTable($idHistorico INTEGER PRIMARY KEY, 
      $vagaEstacionamentoHistorico INTEGER, $clienteHistorico TEXT,
      $dataEntradaHistorico TEXT, $dataSaidaHistorico TEXT, 
      FOREIGN KEY ($vagaEstacionamentoHistorico)
      REFERENCES $estacionamentoTable($vagaEstacionamento))""",
    ];
    for(String query in queries){
      await db.execute(query);
    }
    await db.close();

  }


  Future insertVagas(Map<String, dynamic> row)async{
    Database db = await _initdatabase();
    await db.insert(estacionamentoTable, row);
    await db.close();

  }

  Future<dynamic> updateVagas( Map<String, dynamic> row, var vaga)async{
    Database db = await _initdatabase();
    await db.update(estacionamentoTable, row,where: '$vagaEstacionamento = ?',
    whereArgs: [
      vaga
    ]);
    await db.close();
  }

  Future insertHistorico(Map<String,dynamic> row)async{
    Database db = await _initdatabase();
    var id = await db.insert(historicoTable, row);
    await db.close();
    return id;
  }
  Future<dynamic> updateHistorico( Map<String, dynamic> row, var id)async{
    Database db = await _initdatabase();
    await db.update(historicoTable, row,where: '$idHistorico = ?',
    whereArgs: [
      id
    ]);
    await db.close();
  }

  Future getVagas(String sql)async{
    Database db = await _initdatabase();
    var result = await db.rawQuery(sql);
    db.close();
    return result;
  }
  Future getHistorico()async{
    Database db = await _initdatabase();
    var result = await db.rawQuery('select * from $historicoTable');
    db.close();
    return result;
  }
  Future getIdHistorico(var vaga)async{
    Database db = await _initdatabase();
    List result = await db.rawQuery('select * from $historicoTable where $vagaEstacionamentoHistorico = ? order by $idHistorico',[
      vaga
    ]);
    db.close();
    return result.last;
  }

  
  Future deletarBanco() async {
    String caminhoDoBanco = await getDatabasesPath();
    String _banco = 'MidasMobile.db';
    String path = join(caminhoDoBanco, _banco);
    deleteDatabase(path);
  }
}