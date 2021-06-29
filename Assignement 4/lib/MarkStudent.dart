import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/indivisualStudentMark.dart';
import 'package:provider/provider.dart';
import 'students.dart';
var selectedweek = "";
var selectedgrade = "";

var student= Student();
CollectionReference users = FirebaseFirestore.instance.collection('students');

class MarkStudent extends StatefulWidget {

  final String id;

  const MarkStudent({Key key, this.id}) : super(key: key);
  @override
  MarkStudentWidget createState() => MarkStudentWidget();
}
enum SingingCharacter { lafayette, jefferson }

class MarkStudentWidget extends State<MarkStudent> {

  String dropdownValue = 'Week 1';
  final _formKey = GlobalKey<FormState>();
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

  String dropdownValue2 = 'HD+';
  List <String> spinnerItems2 = [
    'HD+',
    'HD',
    'DN',
    'CR',
    'PP',
    'NN'
  ] ;

  @override
  Widget build(BuildContext context) {
    var students = Provider.of<StudentModel>(context, listen:false).items;
    var student = Provider.of<StudentModel>(context, listen:false).get(widget.id);
    var adding = student == null;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff885566),
        title: Text(student.name),
          actions: [
            IconButton(
              icon: Icon(Icons.summarize),
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(
                    builder:(context) => indivisualmark(id: student.id)

                ));
                },
            )
          ],
        ),
      body: Center(
        child :
        Column(children: <Widget>[

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
                selectedweek = dropdownValue;
              });
            },
            items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: dropdownValue2,
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
                dropdownValue2 = data;
                selectedgrade = dropdownValue2;
              });
            },
            items: spinnerItems2.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text('$dropdownValue' + ' ' + '$dropdownValue2',
              style: TextStyle
                (fontSize: 22,
                  color: Colors.black)),

          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              student.weekGrade.remove(selectedweek);

              student.weekGrade[selectedweek]= selectedgrade;

              if(selectedweek.isEmpty){
                return Text("Pls Type");
              }
              if(selectedgrade.isEmpty){
                return Text("Pls type");
              }
              users.doc(student.id).set({"week grade" : student.weekGrade}, SetOptions(merge : true));
              print('Add student Marks');
              //weekHolder = null;
              Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  }

}



