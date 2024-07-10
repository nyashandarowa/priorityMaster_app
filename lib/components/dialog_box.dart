import 'package:flutter/material.dart';
import 'package:priority_master/components/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key,
  required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      content: Container(
        height: 150,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          //get user input
           TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
            hintText: "Add a new task"),
          ),

            // buttons=> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save
                MyButton(
                    text: "Save",
                    onPressed: onSave),

                const SizedBox(width: 10,),

                //cancel
                MyButton(
                    text: "Cancel",
                    onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
