import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/tasks.dart';
import 'package:lista_de_tarefas/repositories/tasks_repositories.dart';

import '../widgets/task_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController tasksController = TextEditingController(); //controlador para conseguir pegar o texto do campo de texto
  final TasksRepository tasksRepository = TasksRepository();


  List<Tasks> tasks = [];
  Tasks? deletedTasks;
  int? deletedTasksPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tasksController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicionar uma tarefa',
                          hintText: 'Ex. Estudar Flutter',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text =
                            tasksController.text; //Le o texto do campo
                        setState(() {
                          //setState usado para atualizar a pagina do app , sempre que o botão for acionado
                          Tasks newTasks = Tasks(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          tasks.add(
                              newTasks); //adiciona o que está escrito no campo de texto , dentro da lista criada acima
                        });
                        tasksController.clear();
                        tasksRepository.saveTaskList(tasks);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 93, 170, 6),
                        padding: EdgeInsets.all(14),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Tasks task
                          in tasks) // Para cada tarefa da lista , foi criado um ListTile
                        TaskListItem(
                          tasks: task,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'você possui ${tasks.length} tarefas pendentes',
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDeleteTasksConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 93, 170, 6),
                          padding: EdgeInsets.all(19)),
                      child: Text('Limpar tudo '),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Tasks task) {
    deletedTasks = task;
    deletedTasksPos = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${task.title} foi removida com sucesso!',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color.fromARGB(255, 93, 170, 6),
          onPressed: () {
            setState(() {
              tasks.insert(deletedTasksPos!, deletedTasks!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTasksConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar tudo?'),
        content: Text('Tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 93, 170, 6),
            ),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTasks();
            },
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 93, 170, 6),
            ),
            child: Text('Limpar Tudo'),
          ),
        ],
      ),
    );
  }

  void deleteAllTasks(){
    setState(() {
      tasks.clear();
    });
  }
}
