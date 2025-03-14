class cltodo{
  String? id;
  String? todoitem;
  bool? done;
  cltodo(
  {
    required this.id,
    required this.todoitem,
    this.done= false
}
      );
  static List<cltodo> todolist(){
    return[
      cltodo(id: '01',todoitem: "task1", done:  true),
      cltodo(id: '02',todoitem: "task2", done:  true),
      cltodo(id: '03',todoitem: "task3"),

    ];
  }
}
