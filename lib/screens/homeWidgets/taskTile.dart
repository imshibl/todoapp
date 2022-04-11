// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {required this.title,
      required this.checkBox,
      required this.ontap,
      required this.deleteIcon,
      required this.deleteFunction});

  final Widget checkBox;
  final Widget title;
  final VoidCallback ontap;
  final Widget deleteIcon;
  final VoidCallback deleteFunction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      leading: checkBox,
      trailing: IconButton(
        icon: deleteIcon,
        onPressed: deleteFunction,
      ),
      onTap: ontap,
    );
  }
}

// return ListTile(
//   title: Text(
//     res.task == null ? '' : res.task,
//     style: TextStyle(
//       fontSize: 18.0,
//       fontWeight: FontWeight.w500,
//     ),
//   ),
//   leading: res.complete
//       ? Icon(
//           Icons.check_box,
//           color: Colors.lightBlueAccent,
//         )
//       : Icon(
//           Icons.check_box_outline_blank,
//           color: Colors.lightBlueAccent,
//         ),
//   onTap: () {
//     res.complete = !res.complete;
//     res.save();
//   },
//   trailing: IconButton(
//     icon: Icon(Icons.delete),
//     onPressed: () {
//       res.delete();
//       setState(() {
//         count = box.length;
//       });
//     },
//   ),
// );
