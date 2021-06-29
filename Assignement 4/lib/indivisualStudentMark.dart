import 'dart:collection';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/MarkStudent.dart';
import 'package:flutter_tutorial_3/students.dart';
import 'package:provider/provider.dart';

int HD = 80;

int result = 0;
int count = 0;

class indivisualmark extends StatefulWidget {
  final String id;
  const indivisualmark({Key key, this.id}) : super(key: key);

  @override
  _indivisualmarkState createState() => _indivisualmarkState();
}

class _indivisualmarkState extends State<indivisualmark> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('students').snapshots();
  CollectionReference recipes = FirebaseFirestore.instance.collection(
      'students');
  List<String> weekArray = ['Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
    'Week 6',
    'Week 7',
    'Week 8',
    'Week 9',
    'Week 10',
    'Week 11',
    'Week 12',
    'Week 13'];

    @override
  Widget build(BuildContext context) {
    var students = Provider.of<StudentModel>(context, listen:false).items;
    var student = Provider.of<StudentModel>(context, listen:false).get(widget.id);
    CollectionReference users = FirebaseFirestore.instance.collection('students');

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff885566),
          title: new Text(student.name + ': Summary'),
        ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(student.id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            data.remove('name');
            data.remove('id');
            data.containsKey("Week 1");

            if(data['week grade'] == null){

              return Text("Document is not exist!!");

            }else {
              return ListView.builder(
                  itemCount: weekArray.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                            title: Text(weekArray[index] + data['week grade'][weekArray[index]].toString()),
                            ));
                  });
            }
            }
          return Text("loading");
        },
      ),
    );
  }
  }
