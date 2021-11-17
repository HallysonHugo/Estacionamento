import 'package:get/get.dart';
import 'databasehelper.dart';
class Controller extends GetxController{
  var lista = [].obs;

  var dbHelper = BancoDeDados.instance;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  fetchData()async{
    List result = await dbHelper.getVagas('select * from $estacionamentoTable');
    lista.assignAll(result);
  }

 Future updateVaga(int preenchida, int vaga, int index, {entrada, saida})async{
    await dbHelper.updateVagas({
      vagaPreenchida:preenchida,
      dataEntrada:entrada,
      dataSaida:saida,
    }, vaga);
    fetchData();
  }


  
}