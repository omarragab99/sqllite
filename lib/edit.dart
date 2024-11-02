  import 'package:flutter/material.dart';
import 'package:sqllite/sqldp.dart';

class Edit extends StatefulWidget {
    final id ;
    final note ;
    final color ;


     Edit({super.key, this.id, this.note, this.color});


    @override
    State<Edit> createState() => _EditState();
    
   
  }
  
  class _EditState extends State<Edit> {
    SqlDp sqlDp =SqlDp();
    GlobalKey<FormState> formstate = GlobalKey();
    TextEditingController note = TextEditingController();
    TextEditingController id = TextEditingController();
    TextEditingController color = TextEditingController();
    @override
  void initState() {
  
    note.text = widget.note;
    color.text = widget.color;

    
    super.initState();
  }

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
              int response =  await sqlDp.updatetData('''
                UPDATE notes SET  
                note =  "${note.text}",
                color =  "${color.text}"
                WHERE id = ${widget.id}

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