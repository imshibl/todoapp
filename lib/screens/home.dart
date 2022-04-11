// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/homeWidgets/taskTile.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/client/hive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int count;
  late String task;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      count = Hive.box<Todo>(HiveBoxe.todo).length;
    });

    super.initState();
  }

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List egTodos = [
      "Buy milk",
      "Go for shopping",
      "Print agendas",
      "Finish homework",
      "Call mum",
      "Post a blog",
      "Go to Swim",
      "Go for a walk",
      "Workout",
      "Watch a movie",
      "Read a book",
    ];
    final _random = Random();
    late int _randomNum;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 25.0, right: 25.0, top: 40.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'T',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: 'o',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: 'D',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: 'o',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Pending todos:$count',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Todo>(HiveBoxe.todo).listenable(),
                builder: (context, Box<Todo> box, _) {
                  if (box.values.isEmpty) {
                    return Center(
                      child: Text('Todo List is Empty'),
                    );
                  }

                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Todo? res = box.getAt(index);

                      return TaskTile(
                        title: Text(
                          res!.task,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            decoration: res.complete
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        checkBox: res.complete
                            ? Icon(
                                Icons.check_box,
                                color: Colors.greenAccent,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.greenAccent,
                              ),
                        ontap: () {
                          res.complete = !res.complete;
                          res.save();
                        },
                        deleteIcon: Visibility(
                          visible: res.complete,
                          child: Icon(Icons.delete),
                        ),
                        deleteFunction: () {
                          if (res.complete) {
                            res.delete();
                          }
                          setState(() {
                            count = box.length;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo',
        onPressed: () {
          _randomNum = _random.nextInt(egTodos.length);
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom:
                      //to check wheather keyboard is visible or not,if bottom > 0.0 keypad is visibile else not visible
                      WidgetsBinding.instance!.window.viewInsets.bottom > 0.0
                          ? MediaQuery.of(context).size.width * 0.7
                          : MediaQuery.of(context).size.width * 0.0,
                ),
                child: Container(
                  //modalbottomsheet
                  color: Color(0xff757575),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Add Todo',
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 26.0),
                            textAlign: TextAlign.center,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: egTodos[_randomNum],
                              labelStyle:
                                  TextStyle(color: const Color(0xFF424242)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.greenAccent),
                              ),
                            ),
                            autofocus: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(
                                () {
                                  task = value;
                                },
                              );
                            },
                            validator: (val) {
                              return val!.trim().isEmpty
                                  ? 'Task name should not be empty'
                                  : null;
                            },
                          ),
                          SizedBox(height: 3.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent),
                            onPressed: () {
                              _validateAndSave();
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 33,
        ),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      _onFormSubmit();
    } else {
      // print('Form is invalid');
    }
  }

  void _onFormSubmit() {
    Box<Todo> todoBox = Hive.box<Todo>(HiveBoxe.todo);
    todoBox.add(Todo(task: task));
    setState(() {
      count = Hive.box<Todo>(HiveBoxe.todo).length;
    });

    Navigator.pop(context);
  }
}
