import 'package:flutter/material.dart';
import 'package:tarefas/components/task.dart';
import 'package:tarefas/data/task_dao.dart';
import 'package:tarefas/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(onPressed: (){setState((){});}, icon: Icon(Icons.refresh))
        ],
        title: const Text('Tarefas'),


      ),

      body: Padding(padding: EdgeInsets.only(top:8, bottom:70),child: FutureBuilder(future: TaskDao().findAll(),
          builder: (context,snapshot){

            List<Task> ?items=snapshot.data;
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Carregando',
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                );
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Carregando',
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Carregando',
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                );
                break;
              case ConnectionState.done:
                if(snapshot.hasData && items!=null){
                  if (items.isNotEmpty){
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];
                            return tarefa;
                          });
                    }
                    return Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_rounded, size: 128),
                          Text(
                            'Não há nenhuma tarefa',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text('Erro ao carregar tarefas');
                  break;
              }
              return Text('Erro desconhecido');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(taskContext: context,),
            ),
          ).then((value) => setState((){print('Recarregando');}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
