import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/MarkStudent.dart';
import 'package:flutter_tutorial_3/students.dart';
import 'package:provider/provider.dart';

CollectionReference u = FirebaseFirestore.instance.collection('students');
FirebaseFirestore firestore = FirebaseFirestore.instance;
Stream collectionStream = FirebaseFirestore.instance.collection('students').snapshots();
Stream documentStream = FirebaseFirestore.instance.collection('students').doc(student.id).snapshots();


// ignore: camel_case_types
class totalstudentsummary extends StatefulWidget {
  final String id;

  const totalstudentsummary({Key key, this.id}) : super(key: key);

  @override
  _totalstudentsummaryState createState() => _totalstudentsummaryState();
}

// ignore: camel_case_types
class _totalstudentsummaryState extends State<totalstudentsummary> {

  var students = Student();
  var HDPlus = 90;
  var HD = 80;
  var DN = 70;
  var CR = 60;
  var PP = 50;
  var NN = 0;
  var resultOfTotal = 0;
  var num = 0;
  var num2 = 0;
  String dropdownValue = 'Week 1';
  var resultOfGrade;

  List <String> spinnerItems = [
    'Week 1',
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
    'Week 13'
  ] ;

  @override
  Widget build(BuildContext context) {

    var students = Provider.of<StudentModel>(context, listen:false).items;
    var student = Provider.of<StudentModel>(context, listen:false).get(widget.id);
    var a = Student();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff885566),
          title: Text("Total Summary"),
          actions: [

          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String data) {
                      setState(() {
                        dropdownValue = data;
                        num = 0;

                        for(var w in students){

                          if(w.weekGrade.containsKey(dropdownValue)){

                            if(w.weekGrade.containsValue("HD+")){
                              resultOfTotal += HDPlus;
                              num++;
                              print("result Of Total HD+  $resultOfTotal");

                            }else if(w.weekGrade.containsValue("HD")){
                              resultOfTotal += HD;
                              num++;
                              print("result Of Total HD  $resultOfTotal");

                            }else if(w.weekGrade.containsValue("DN")){
                              resultOfTotal += DN;
                              num++;
                              print("result Of Total DN  $resultOfTotal");
                            }else if(w.weekGrade.containsValue("CR")){
                              resultOfTotal += CR;
                              num++;
                              print("result Of Total CR  $resultOfTotal");
                            }else if(w.weekGrade.containsValue("PP")){
                              resultOfTotal += PP;
                              num++;
                              print("result Of Total PP  $resultOfTotal");
                            }else{
                              resultOfTotal += NN;
                              num++;
                              print("result Of Total NN  $resultOfTotal");
                            }
                          }
                        }
                        for(var w in students){

                          if(w.weekGrade.containsKey(dropdownValue)){

                            if(resultOfTotal >= 100){
                              resultOfGrade = "HD+";
                              num2++;
                              print("result Of Total Grade HD Plus  $resultOfGrade");

                            }else if(resultOfTotal <= 99 && resultOfTotal >= 80){
                              resultOfGrade = "HD";
                              num2++;
                              print("result Of Total Grade HD  $resultOfGrade");

                            }else if(resultOfTotal <= 79 && resultOfTotal >= 70){
                              resultOfGrade = "DN";
                              num2++;
                              print("result Of Total Grade HD  $resultOfGrade");
                            }else if(resultOfTotal <= 69 && resultOfTotal >= 60){
                              resultOfGrade = "CR";
                              num2++;
                              print("result Of Total Grade CR  $resultOfGrade");
                            }else if(resultOfTotal <= 59 && resultOfTotal >= 50){
                              resultOfGrade = "PP";
                              num2++;
                              print("result Of Total Grade PP  $resultOfGrade");
                            }else if(resultOfTotal <= 49){
                              resultOfGrade = "NN";
                              num2++;
                              print("result Of Total Grade NN  $resultOfGrade");
                            }
                          }
                        }

                      });
                    },
                    items: spinnerItems.map<DropdownMenuItem<String>>((String value) {


                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ListTile(

                    title: Text((resultOfTotal/num).toString() + '%'),
                    subtitle: Text((resultOfGrade).toString()),
                  )
                ]
            )
        )
    );
  }
}