import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'students.dart';


class StudentDetails extends StatefulWidget
{

  final String id;

  const StudentDetails({Key key, this.id}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    var students = Provider.of<StudentModel>(context, listen:false).items;
    var ParticularStudent = Provider.of<StudentModel>(context, listen:false).get(widget.id);

    var adding = ParticularStudent == null;
    if (!adding) {
      titleController.text = ParticularStudent.name;
      yearController.text = ParticularStudent.student_id.toString();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff885566),
          title: Text(adding ? "Add Student" : "Edit Student"),
          actions: [
            IconButton(
              color: Colors.pink,
              icon: Icon(Icons.delete_outline),
              onPressed: (){
              if (_formKey.currentState.validate())
              {
                  Provider.of<StudentModel>(context, listen:false).delete(ParticularStudent.id);
                  print('Deleted student');
                  Navigator.pop(context);
              }
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (adding == false) Text("Student Index ${widget.id}"), //check out this dart syntax, lets us do an if as part of an argument list
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: "Name"),
                            controller: titleController,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Student Id"),
                            controller: yearController,
                          ),


                          ElevatedButton.icon(onPressed: () {
                            if (_formKey.currentState.validate())
                            {
                              if (adding)
                              {
                                ParticularStudent = Student();
                              }
                              ParticularStudent.name = titleController.text;
                              ParticularStudent.student_id = int.parse(yearController.text); //good code would validate these

                              //TODO: update the model
                              if (adding)
                                Provider.of<StudentModel>(context, listen:false).add(ParticularStudent);
                              else
                                Provider.of<StudentModel>(context, listen:false).update(widget.id, ParticularStudent);

                              //return to previous screen
                              Navigator.pop(context);
                            }
                          }, icon: Icon(Icons.save), label: Text("Save Values"))
                        ],
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}

