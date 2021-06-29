import 'dart:collection';



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Student
{
  String id;
  String name;
  int student_id;
  String image;
  Map<String, String> weekGrade = {};


  Student({this.name, this.student_id, this.weekGrade, this.image});
  Student.fromJson(Map<String, dynamic> json)
      :
        name = json['name'],
        student_id = json['id'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'id': student_id
      };
}

class StudentModel extends ChangeNotifier {
  /// Internal, private state of the list.
  final List<Student> items = [];

  CollectionReference studentCollection = FirebaseFirestore.instance.collection('students');

  //added this
  bool loading = false;

  StudentModel()
  {
    fetch();
  }

  void add(Student item) async
  {
    loading = true;
    notifyListeners();

    await studentCollection.add(item.toJson());

    //refresh the db
    await fetch();
  }

  void update(String id, Student item) async
  {
    loading = true;
    notifyListeners();
    //SetOption code is for keep existing data then update new data
    await studentCollection.doc(id).set(item.toJson(),SetOptions(merge : true));

    //refresh the db
    await fetch();
  }

  void delete(String id) async
  {
    loading = true;
    notifyListeners();

    await studentCollection.doc(id).delete();

    //refresh the db
    await fetch();
  }

  void read(String id, Student item) async
  {
    loading = true;
    notifyListeners();

    await await studentCollection.orderBy("Week 1").get();

    //refresh the db
    await fetch();
  }

  void fetch() async
  {
    //clear any existing data we have gotten previously, to avoid duplicate data
    items.clear();

    loading = true;
    notifyListeners();

    var querySnapshot = await studentCollection.orderBy("name").get();

    querySnapshot.docs.forEach((doc) {

      var student = Student.fromJson(doc.data());
      student.id = doc.id;
      items.add(student);
    });
    await Future.delayed(Duration(seconds: 2));

    //we're done, no longer loading
    loading = false;
    notifyListeners();
  }
  Student get(String id)
  {
    if (id == null) return null;
    return items.firstWhere((student) => student.id == id);
  }
}
