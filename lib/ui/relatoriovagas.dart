// ignore_for_file: file_names

import 'package:estacionamento/getcontroller_historico.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:estacionamento/databasehelper.dart';
import 'package:get/get.dart';



var dbHelper = BancoDeDados.instance;

class RelatorioVagas extends StatelessWidget {
   RelatorioVagas({ Key? key }) : super(key: key);
  final controller = Get.put(ControllerHistorico());

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico de vagas'),
      ),
      body: Column(
        children: [
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
              const Text('Permanece na vaga',style: TextStyle(fontSize:15,))
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
              const Text('Liberado',style: TextStyle(fontSize:15,))
                ],
              ),),
              
              
            ],
          ),
          Expanded(
            child: GetX<ControllerHistorico>(
              builder: (controller){
                return ListView.builder(
                  itemCount: controller.lista.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        shape: Border(
                          right: BorderSide(
                            color: controller.lista[index][dataSaidaHistorico] == null ? Colors.red :
                            Colors.green,
                            width: 15
                          )
                        ),
                        elevation: 4,
                        child: Column(
                          children: [
                            Text('Vaga: ${controller.lista[index][vagaEstacionamentoHistorico]}',style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            Text('Cliente: ${controller.lista[index][clienteHistorico]}',style: const TextStyle(
                              fontSize: 20,),),
                            Text('Data de Entrada: ${controller.lista[index][dataEntradaHistorico] ?? ''}',style: const TextStyle(
                              fontSize: 16,
                              
                            ),),
                            Text('Data de Saida: ${controller.lista[index][dataSaidaHistorico] ?? ''}',style: const TextStyle(
                              fontSize: 16,
                             
                            ),),
                            Text(controller.lista[index][dataSaidaHistorico] == null ? 'Situação: Permanece na vaga':'Situação: Liberado',
                            style: const TextStyle(
                              fontSize: 16
                            ),)
                          ],
                        ),
                      ),
                    );
                  }
                );
              },
            ),
          ),
        ],
      )
    );
  }
}