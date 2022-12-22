class Tasks {

Tasks({required this.title, required this.dateTime});

String title;
DateTime dateTime;


Map<String, dynamic>toJson(){
  return{
    'title': title,
    'datetime': dateTime.toIso8601String(),
  };
}



}