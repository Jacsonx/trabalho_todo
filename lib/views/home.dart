import 'package:flutter/material.dart';
import 'package:trabalho_todo/models/tarefa.dart';
import 'package:trabalho_todo/views/nova_tarefa.dart';

class Home extends StatefulWidget {

  List<Tarefa> tarefas = new List<Tarefa>();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Lista de Tarefas')
      ),
      body: Container(
        child: widget.tarefas.length == 0
            ? Center(
                child: Text('Nenhuma Tarefa adicionada ainda'),
              )
            : ListView.builder(
                itemCount: widget.tarefas.length,
                itemBuilder: (BuildContext context, int i) {
                  final Tarefa tarefa = widget.tarefas[i];
                  return CheckboxListTile(
                    title: Text(tarefa.nome),
                    subtitle: Text(tarefa.descricao),
                    onChanged: (bool value) {
                      setState(() => tarefa.pronta = value);
                    },
                    value: tarefa.pronta,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTarefa(),
        child: Icon(Icons.add),
      ),
    );
  }


 addTarefa() async {
    final Tarefa result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NovaTarefa(),
        ));

    if (result != null) {
      var tarefa = new Tarefa(
        nome: result.nome,
        descricao: result.descricao,
        pronta: false,
      );
      setState(() {
        widget.tarefas.add(tarefa);
      });
    }
  }
}
