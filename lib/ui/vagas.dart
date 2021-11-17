
import 'package:flutter/material.dart';
import 'package:estacionamento/databasehelper.dart';
import 'package:estacionamento/getcontroller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



// ignore: must_be_immutable
class VagasPage extends StatelessWidget {
  VagasPage({ Key? key}) : super(key: key);

  final dbHelper = BancoDeDados.instance;
  final situacaoControl = Get.put(Controller());
  
  
 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vagas Estacionamento'),
      ),
      body: Column(
        children:   [
          Row(
            children: [
             Padding(padding: const EdgeInsets.only(left: 10,top: 10),
              child: Row(
                children: [
                  Container(
                color: Colors.red,
                width: 10,
                height: 10,
              ),
              const Text('Ocupado',style: TextStyle(fontSize:15,))
                ],
              ),),
              
                Padding(padding: const EdgeInsets.only(left: 10,top: 10),
              child: Row(
                children: [
                  Container(
                color: Colors.green,
                width: 10,
                height: 10,
              ),
              const Text('Livre',style: TextStyle(fontSize:15,))
                ],
              ),),
              
              
            ],
          ),
         Expanded(
           child: GetX<Controller>(builder: (controller){
           return ListView.builder(
       
           itemCount:controller.lista.length,
           itemBuilder: (context, index){
              Map<String,String> cliente = {
                'RESULTADO':''
              };
              
              return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                shape: Border(
                  right: BorderSide(
                    color: controller.lista[index][vagaPreenchida] == 0 ? Colors.green : Colors.red,
                    width: 15
                  )
                ),
                elevation: 4,
                child: Column(
                  children: [
                    
                    Text("""Data de Entrada: ${controller.lista[index][dataEntrada]?? ''}    Data de Saída: ${controller.lista[index][dataSaida]??''}"""),
                    Text('Vaga n° ${controller.lista[index][vagaEstacionamento]}',style: const TextStyle(fontSize: 22)),
                    controller.lista[index][vagaPreenchida] == 0 ? const Text('Vaga Livre',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)):
                    const Text('Vaga Ocupada',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: controller.lista[index][vagaPreenchida] == 0? ()async{
                      final TextEditingController textController = TextEditingController();
                       var dataEntrada = DateTime.now();
                       var dataFormatada = formatarData(dataEntrada);
                       cliente = await Get.defaultDialog(
                         title: 'Informe o Cliente',
                         content:  TextField(
                           controller: textController,
                         ),
                         actions: [
                           TextButton(
                             onPressed: (){
                               Get.back(result: {
                                 'RESULTADO':textController.text
                               });
                             },
                             child: const Text('Ok'),
                           ),
                           TextButton(
                             onPressed: (){
                               Get.back();
                             },
                             child: const Text('Cancelar'),
                           )
                         ]
                        );
  
                        await situacaoControl.updateVaga(1, controller.lista[index][vagaEstacionamento], index,entrada: dataFormatada);
                       await dbHelper.insertHistorico({
                          vagaEstacionamentoHistorico:controller.lista[index][vagaEstacionamento],
                          clienteHistorico:cliente['RESULTADO'],
                          dataEntradaHistorico:dataFormatada
                        });
                    }:null, 

                      child:const Text('Entrada')),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      ElevatedButton(onPressed:controller.lista[index][vagaPreenchida] == 1? ()async{
                        var resultHistorico = await dbHelper.getIdHistorico(controller.lista[index][vagaEstacionamento]);
                        var dataSaida = DateTime.now();
                        var dataFormatada = formatarData(dataSaida);
                        await situacaoControl.updateVaga(0, controller.lista[index][vagaEstacionamento], index,saida: dataFormatada);
                        await dbHelper.updateHistorico({
                          dataSaidaHistorico:dataFormatada,
                        },resultHistorico[idHistorico]);
                    
                    }: null, 
                      child:const Text('Saída'))
                    ],),
                  
                
                  ],
                ),
              ),
            );
          }
          );
         }),
         )
        ],
      ),
    );
  }
  String formatarData(DateTime data){
    var dateFormatter = DateFormat('dd/MM/yyyy');
    var dataFormatada = dateFormatter.format(data);
    return dataFormatada;
  }
  }