import 'package:estacionamento/databasehelper.dart';
import 'package:estacionamento/ui/relatorioVagas.dart';
import 'package:estacionamento/ui/vagas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {
   HomePage({ Key? key }) : super(key: key);

  final dbHelper = BancoDeDados.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [   
            const Padding(padding: EdgeInsets.only(top: 22)),
            
            Expanded(
              child: Stack(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    ),
                    child: Column(
                      children: [
                        
                       const Padding(padding: EdgeInsets.only(top: 10),),
                       Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage('images/logo.png'))
                              ),
                            ),
                        Expanded(
                          child: GridView(
                            gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            children: [
                            
                                  menu('images/car-parking.png', 'Vagas', 20,vagasPage),
                                  menu('images/history.png', 'Historico de Vagas', 20,relatoriosPage)

                                  /*
                                  ElevatedButton(
                                    onPressed: ()async{
                                      await getVagas();
                              
                                      Get.to(()=>VagasPage());
                                    },
                                    child: const Text('Vagas'),
                                  ),
                                  ElevatedButton(
                                    onPressed: ()async{
                                  // await dbHelper.getVagas('delete from $historicoTable');
                                  // await dbHelper.getVagas('delete from $estacionamentoTable');
                                    // ignore: prefer_const_constructors
                                    Get.to(()=> RelatorioVagas());
                                    },
                                    child: const Text('Relatorio diário'),
                                  ),*/
                                
                              
                      
                            ],
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );

    
  }

  Future<dynamic> vagasPage()async{
   await getVagas();                           
   Get.to(()=>VagasPage());
  }

 Future<dynamic> relatoriosPage()async{
    Get.to(()=> RelatorioVagas());
  }

  Widget menu(String imagem, String texto, double tamanho, var funcao){
    return GestureDetector(
      onTap: funcao,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(20)
            ),
            child: Container(
              decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: AssetImage(imagem),scale: 6),
              color: Colors.blue[800],),
              height: 170,
              width: 170,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 15),child: Text(
                    texto,
                    style:const  TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold
                    ),
                  ),),
                ],
              ),
            ),
          ),
        ),
    );
  }



  Future getVagas()async{
  List result = await dbHelper.getVagas('select * from $estacionamentoTable');
  if(result.isEmpty){
    for(var i = 1; i<11; i++){
      await dbHelper.insertVagas({
      vagaPreenchida:0
    });
    }
  } 
}
}