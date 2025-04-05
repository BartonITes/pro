import 'package:flutter/material.dart';
import 'package:projectaro/todo.dart';
import 'package:projectaro/class_todo.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.tasks}) : super(key: key);
  final List<cltodo> tasks;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<cltodo> todoList;
  final addcontrol = TextEditingController();
  List<cltodo> found = [];

  @override
  void initState() {
    super.initState();
    todoList = widget.tasks;  // Initialize todoList with tasks passed from Home widget
    found = todoList;  // Set the found list to all tasks initially
  }

  // Toggle task completion status
  void handler(cltodo task) {
    setState(() {
      task.done = !(task.done ?? false);  // Toggle the task done status safely
    });
  }

  // Add a new task
  void add(String t) {
    setState(() {
      todoList.add(cltodo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoitem: t,
      ));
    });
    addcontrol.clear();  // Clear the input field
    search("");  // Update the found list to include the newly added task
  }

  // Search for tasks
  void search(String tasksearch) {
    List<cltodo> result = [];
    if (tasksearch.isEmpty) {
      result = todoList;  // If search query is empty, show all tasks
    } else {
      result = todoList.where((item) =>
      item.todoitem?.toLowerCase().contains(tasksearch.toLowerCase()) ??
          false).toList();
    }
    setState(() {
      found = result;  // Update the found list based on search results
    });
  }

  // Delete a task by id
  void deleteitem(String id) {
    setState(() {
      todoList.removeWhere((task) => task.id == id);
      search("");  // Re-run the search after deletion to update the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.transparent,
        title: titleBar(),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value) => search(value),  // Call search on text change
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "To Dos",
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Display each todo item
                      for (cltodo task in found.reversed)
                        Todo(
                          tasks: task,
                          tohandle: handler,
                          delete: deleteitem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: addcontrol,
                      decoration: InputDecoration(
                        hintText: 'Add Task!! : )',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      add(addcontrol.text);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      elevation: 10,
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget titleBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(Icons.menu, color: Colors.black, size: 30),
      Container(
        height: 40,
        width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset('assets/images'),
        ),
      ),
    ],
  );
}
