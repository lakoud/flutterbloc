
import 'package:app_pfa/data/todo.dart';
import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
    const TodoEvent();
    @override  
    List<Object?> get  props=> [ ];
  
}

class TodoStarted extends TodoEvent {}


class AddTodo extends TodoEvent {
    final ToDo todo;
    const AddTodo(this.todo);
    @override  
    List<Object>get props =>[todo ];
    
}
class RemoveTodo extends TodoEvent {
    final ToDo todo;
    const RemoveTodo(this.todo);
    @override  
    List<Object>get props =>[todo ];
    
}

class AlterTodo extends TodoEvent {
    final int index;
    const AlterTodo(this.index);
    @override  
    List<Object>get props =>[index ];
    
}

