import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/tasks.dart';

class TasksRepository{

TasksRepository(){
  SharedPreferences.getInstance().then((value){ 
    sharedPreferences = value ;
    print(sharedPreferences.getString('task_list'));
  });
}

  late SharedPreferences sharedPreferences;

  void saveTaskList(List<Tasks> tasks) {
    final jsonString = json.encode(tasks);
    sharedPreferences.setString('task_list',jsonString);
    
  }


}