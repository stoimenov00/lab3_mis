import 'dart:collection';

import 'package:flutter/material.dart';

void main() => runApp(new ExamListApp());

class ExamListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(debugShowCheckedModeBanner: false, title: 'Exam App', home: new ExamList());
  }
}

class ExamList extends StatefulWidget {
  @override
  createState() => new ExamDemoListState();
}

class ExamDemoListState extends State<ExamList> {
  List<String> ExamItemsArrayList = [];
  Map<String, String> _exams = new HashMap<String, String>();
  String _newexam = "";
  String _newDate = "";

  void _addExam() {
    if (_newexam.length > 0) {
      setState(() {
        print("ime ispit: " + _newexam + "  datum:  " + _newDate);
        _exams[_newexam] = _newDate;
      });
    }
  }

  void _setNewexamState(String ispit) {
    if (ispit.length > 0) {
      setState(() {
        _newexam = ispit;
      });
    }
  }

  void _setNewexamDateState(String date) {
    if (date.length > 0) {
      setState(() {
        _newDate = date;
      });
    }
  }

  void ExamItemListAdd(String task) {
    if (task.length > 0) {
      setState(() {
        ExamItemsArrayList.add(_newexam + "\n" + _newDate);
      });
    }
  }

  // Build the whole list of exam items
  Widget AppBarBuildExamList() {
    return new ListView.builder(
      itemCount: _exams.length,
      itemBuilder: (context, index) {
        String key = _exams.keys.elementAt(index);
        return new Card(
          child: new ListTile(
            title: Column(
              children: [
                new Text(
                  "$key",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Text(
                  "${_exams[key]}",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
          margin: EdgeInsets.all(10),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Лаб 3 Фидан Стоименов'),
        actions: [
          IconButton(onPressed: newAddExamScreen, icon: Icon(Icons.add))
        ],
      ),
      body: AppBarBuildExamList(),
    );
  }

  void newAddExamScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Додај испит')),
          body: Column(
            children: [
              new TextField(
                autofocus: true,
                onSubmitted: (val) {
                  _addExam();
                },
                onChanged: (val) {
                  _setNewexamState(val);
                },
                decoration: new InputDecoration(hintText: 'Име на предмет', contentPadding: const EdgeInsets.all(20.0)),
              ),
              new TextField(
                autofocus: true,
                onSubmitted: (val) {
                  _addExam();
                  ExamItemListAdd(val);
                  Navigator.pop(context);
                },
                onChanged: (val) {
                  _setNewexamDateState(val);
                },
                decoration: new InputDecoration(hintText: 'Термин', contentPadding: const EdgeInsets.all(20.0)),
              )
            ],
          ));
    }));
  }
}
