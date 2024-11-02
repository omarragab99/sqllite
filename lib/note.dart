import 'package:flutter/material.dart';
import 'package:sqllite/edit.dart';
import 'package:sqllite/sqldp.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDp sqlDp =   SqlDp();  
  List notes =[];
  bool isloading =true;


Future readData()async{

   List<Map> response =  await sqlDp.readData("SELECT*FROM'notes'");
   notes.addAll(response);
   isloading=false;
   if(this.mounted){
    setState(() {
      
    });
   }
  
} 
@override
  void initState() {
    readData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOMEPAGE"),),
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.of(context).pushNamed("addnote"); },
      child: Icon(Icons.add),),
      body: Container(child: ListView(
        children: [
          MaterialButton(onPressed: ()async{
            await sqlDp.mydeleteDatabase();
          },child: Text("delete database"),),
           ListView.builder(
                itemCount: notes.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                
                itemBuilder: (context ,i){
                  return Card(child: ListTile(title: Text("${notes[i]['note']}"),
                  subtitle: Text("${notes[i]['color']}"),
          
                  trailing:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: ()async{
                  int response = await sqlDp.deleteData("DELETE FROM notes WHERE id = ${notes[i]['id']} ");
                  if(response>0){
                    notes.removeWhere((element) => element['id']==notes[i]['id']);
                    setState(() {
                      
                    });
                  }
                  }, icon:Icon(Icons.delete,color: Colors.red,) ),
                  IconButton(onPressed: ()async{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit(
                      id : notes [i]['id'],
                      note : notes [i]['note'],
                      color : notes [i]['color'],
                    ),),);
                 
                  
                  }, icon:Icon(Icons.edit,color: Colors.blue,) ),
                    ],)
                  ));

              })  

            
            
        
         
        ],
      )),
    );
  }
}