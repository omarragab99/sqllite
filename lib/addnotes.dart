  import 'package:flutter/material.dart';
import 'package:sqllite/sqldp.dart';

class AddNotes extends StatefulWidget {
     AddNotes({super.key});
  
    @override
    State<AddNotes> createState() => _AddNotesState();
   
  }
  
  class _AddNotesState extends State<AddNotes> {
    SqlDp sqlDp =SqlDp();
    GlobalKey<FormState> formstate = GlobalKey();
    TextEditingController note = TextEditingController();
    TextEditingController id = TextEditingController();
    TextEditingController color = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Notes'),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
          Form(key: formstate,child: Column(
            children: [
              TextFormField(
                controller: id,
                decoration: InputDecoration(
                  hintText: "id "
                ),

              ),
              TextFormField(
                controller: note,
                decoration: InputDecoration(
                  hintText: "note "
                ),
              ),
              TextFormField(
                controller: color,
                decoration: InputDecoration(
                  hintText: "color "
                ),
              ),
              SizedBox(height: 20,),
              Center(child: ElevatedButton(onPressed: ()async{
              int response =  await sqlDp.insertData('''
                INSERT INTO notes ('id' , 'note','color')
                VALUES ("${id.text}","${note.text}","${color.text}")
                     ''');
                     if(response > 0 ){
                      Navigator.of(context).pushNamed("home");
                     }
              }, 
              
              child:
            
              Text("SAVE ",style: TextStyle(color: Colors.white)),), )

            ],

          ),)
        ]),
      );
    }
  }