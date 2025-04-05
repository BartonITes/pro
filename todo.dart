import 'package:flutter/material.dart';
import 'package:projectaro/class_todo.dart';

class Todo extends StatelessWidget {
  final cltodo tasks;
  final Function tohandle;
  final Function delete;

  const Todo({
    Key? key,
    required this.tasks,
    required this.tohandle,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDone = tasks.done ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.grey,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        onTap: () {
          // This will call the `tohandle` function, passing the `tasks` object.
          tohandle(tasks);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white60,
        leading: Icon(
          isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.white,
        ),
        title: Text(
          tasks.todoitem ?? "No Task",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 37,
          width: 37,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              // This will call the `delete` function, passing the `tasks.id`.
              delete(tasks.id);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
