// ignore_for_file: non_constant_identifier_names

class ToDoItem {
  int Id;
  String Description;
  bool Completed;

  ToDoItem(
      {required this.Id, required this.Description, required this.Completed});

  ToDoItem.fromJson(Map<String, dynamic> json)
      : Id = json["Id"],
        Description = json["Description"],
        Completed = json["Completed"];
}
