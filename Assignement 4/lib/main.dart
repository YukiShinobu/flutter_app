import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/studentDetails.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MarkStudent.dart';
import 'TotalStudentSummary.dart';
import 'students.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    //BEGIN: the old MyApp builder from last week
    return ChangeNotifierProvider(
        create: (context) => StudentModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'Tutor Mark',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Tutor Mark Home Page')
        )
    );
    //END: the old MyApp builder from last week
  }
}

class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(
        builder:buildScaffold
    );
  }

  // ignore: non_constant_identifier_names
  Scaffold buildScaffold(BuildContext context, StudentModel ModelOfStudent, _) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff885566),
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.grading_outlined),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder:(context) => totalstudentsummary()

              ));
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff885566),
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return StudentDetails();
          });
        },
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            if (ModelOfStudent.loading) CircularProgressIndicator() else Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (_, index) {
                    var student = ModelOfStudent.items[index];
                    return Card(
                      child: ListTile(
                        title: Text(student.name), subtitle: Text(student.student_id.toString() + "  "),leading: Icon(
                        Icons.person_outlined,
                      ),


                        trailing: IconButton(
                        icon: Icon(Icons.fact_check),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder:(context) => MarkStudent(id: student.id)
                          ));
                        },
                      ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return StudentDetails(id: student.id);
                              }));
                        },
                      ),
                    );
                  },
                  itemCount: ModelOfStudent.items.length
              ),
            )
          ],
        ),
      ),
    );
  }
}

//A little helper widget to avoid runtime errors -- we can't just display a Text() by itself if not inside a MaterialApp, so this workaround does the job
class FullScreenText extends StatelessWidget {
  final String text;

  const FullScreenText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection:TextDirection.ltr, child: Column(children: [ Expanded(child: Center(child: Text(text))) ]));
  }
}