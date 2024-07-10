import 'package:hive_flutter/hive_flutter.dart';

class PriorityDatabase {

  List priorityList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
 void createInitialData() {
   priorityList = [
     ["Bake a cake", false],
     ["Do exercises", false],
   ];

  }

  //load data from the database
void loadData () {
   priorityList = _myBox.get("PriorityList");

}

//update the database
void updateDatabase () {
   _myBox.put("PriorityList", priorityList);

}
}