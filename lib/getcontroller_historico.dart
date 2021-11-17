import 'package:get/get.dart';
import 'databasehelper.dart';
class ControllerHistorico extends GetxController{
  var lista = [].obs;

  var dbHelper = BancoDeDados.instance;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  fetchData()async{
    List result = await dbHelper.getHistorico();
   /* for(var i in result){
      Map<String,dynamic> map ={
        vagaEstacionamento:i[vagaEstacionamento],
        vagaPreenchida:i[vagaPreenchida],
        dataEntrada:i[dataEntrada],
        dataSaida:i[dataSaida],
      };
      newList.add(map);
    }*/
    lista.assignAll(result);
  }

  
}