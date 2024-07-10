import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:priority_master/components/dialog_box.dart';
import 'package:priority_master/components/priority_tile.dart';
import 'package:priority_master/data/database.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  PriorityDatabase db = PriorityDatabase();

  @override
  void initState () {
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get("ToDoList") == null) {
      db.createInitialData();

    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();

  }

  //text controller
  final _controller = TextEditingController();


  //checkbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.priorityList[index] [1] = !db.priorityList[index][1];

    });
    db.updateDatabase();
  }

  //save new task method
  void saveNewTask() {
    setState(() {
     db.priorityList.add([_controller.text, false]);
     _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create new task method
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    },
    );
  }

  //delete task
  void deleteTask (int index) {
  setState(() {
    db.priorityList.removeAt(index);
  });
  db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.orangeAccent[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          'Priority List',
        ),
      ),

    floatingActionButton: FloatingActionButton(
      onPressed: createNewTask,
      child: Icon(Icons.add),
      backgroundColor: Colors.blueAccent,
    ),

    body: ListView.builder(
      itemCount: db.priorityList.length,
      itemBuilder: (context, index) {
        return PriorityTile(taskName: db.priorityList[index] [0],
            taskCompleted: db.priorityList[index] [1],
            onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
        );
      },

    )
    );
  }
}
