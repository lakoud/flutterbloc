

import 'package:app_pfa/data/todo.dart';
import 'package:equatable/equatable.dart';

enum TodoStatus  {initial,loading,success,error}

 class TodoState extends Equatable {
    final TodoStatus status;
    final List<ToDo> todos;
    
const TodoState({
    this.todos=const <ToDo> [ ],
    this.status=TodoStatus.initial
 });

TodoState  copyWith({
    final TodoStatus? status,
    final List<ToDo>? todos,
    }
){ return TodoState(
        status: status  ?? this.status,
        todos: todos  ??  this.todos,
      
    );
}
 @override  
 factory TodoState.fromJson(Map<String,dynamic>json){
    try {
      var listOfTodos=(json['todo'] as List<dynamic>)
      .map((e)=>ToDo.fromJson(e as Map<String , dynamic>))
      .toList();
        return TodoState(
            todos: listOfTodos,
            status: TodoStatus.values.firstWhere((element) => element.name.toString()==json[ 'status'])
        );

    } catch (e) {
      rethrow;

    }
        }  
        
        Map<String,dynamic>toJson(){
            return { 
                'todo':todos,
                'status':status.name
            };
        }

   @override  
   List<Object?>get props => [todos,status];
        }
   



