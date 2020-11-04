class Task {
  int id = 0;
  String title = "";
  String hora = "";
  String tag = "";
  String data = "";

  Task({
    this.id,
    this.title,
    this.hora,
    this.tag,
    this.data,
  });


  Task.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['task'];
    hora = json['hour'];
    tag = json['tag'];
    data = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'hora': hora,
      'tag': tag,
      "data":data
    };
  }
}