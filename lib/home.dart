import 'package:app_pfa/bloc/todo_bloc.dart';
import 'package:app_pfa/bloc/todo_event.dart';
import 'package:app_pfa/bloc/todo_state.dart';
import 'package:app_pfa/data/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    addTodo(ToDo todo){
context.read<TodoBloc>().add(
    AddTodo(todo)
);
    }

     removeTodo(ToDo todo){
context.read<TodoBloc>().add(
    RemoveTodo(todo)
);
    }

      AlertTodo(int index){
context.read<TodoBloc>().add(
    AlterTodo(index)
);
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(
                CupertinoIcons.add,
                color: Colors.black,
            ),
            onPressed:() {
          showDialog(context: context,
           builder: (context) {
            TextEditingController contrller1=TextEditingController();
                        TextEditingController contrller2=TextEditingController();

            return AlertDialog(
                title: Text('add '),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    TextField(
                        controller: contrller1,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                            hintText: 'Task Title .. ',
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey
                            ))
                        ),
                    ),
                    const SizedBox(height: 10,),
                         TextField(
                        controller: contrller2,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                            hintText: 'Task Descripption.. ',
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey
                            ))
                        ),
                    )
               
               
                ]),
                actions: [
                    TextButton(
                        onPressed:() {
                      addTodo(
                        ToDo(title: contrller1.text, subtitle: contrller2.text)
                      );
                      contrller1.text='';
                      contrller2.text='';
                      Navigator.pop(context);
                    }, 
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Theme.of(context).colorScheme.secondary,

                            ),
                            borderRadius: BorderRadius.circular(10),

                        ),
                        foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Icon(
                            CupertinoIcons.check_mark,
                            color: Colors.green,
                        ),
                    ))
                ],
            );
            

           }
        );
        },),
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            title:  Text(
                'ToDo',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold
                ),
            ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodoBloc,TodoState>(
            builder: (context, state) {
              if (state.status==TodoStatus.success) {
                return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder:(context, i) {
                    return Card(
                        color: Theme.of(context).colorScheme.primary,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Slidable(
                            key:const ValueKey(0),
                            startActionPane:ActionPane(
                                motion:const ScrollMotion(),
                                children: [
                                    SlidableAction(onPressed:(context) {
                                      removeTodo(state.todos[i]);

                                    },
                                    backgroundColor:  Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    )
                                ],
                                
                            ), child: ListTile(
                                title: Text(
                                    state.todos[i].title
                                ),
                                subtitle: Text(
                                    state.todos[i].subtitle
                                ),
                                trailing: Checkbox(
                                    value: state.todos[i].isDone,
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    onChanged:(value) {
                                      AlertTodo(i);
                                    }),
                                ),
                            ),
                        );
                    
                },
                );
              }else  if (state.status==TodoStatus.initial) {
                return const Center(child: CircularProgressIndicator(),);


              }else{
                return Container();
              }
            },
        ),
        )
    );
  }
}