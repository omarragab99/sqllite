import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDp{
  static Database? _db;
  Future<Database?>get db async{
    if(_db==null){
    _db = await intialDb();// لو مفيش داتا بيز بستدعي 
    return _db;
    }else{
      return _db;
    }

  }


  intialDb()async{
    String databasepath= await getDatabasesPath(); // كدا بخلي الداتا بيز مكنها بيحددو البرنامج
    String path = join(databasepath,'omar.db') ;
    Database mydb =await openDatabase(path,onCreate: _onCreat,version: 5, onUpgrade: _onUpgrade);
    return mydb ;
  }
  _onUpgrade(Database db ,int oldversion , int newversion)async{
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
    print("onUpgrade=============");
  }


  _onCreat(Database db ,int version)async{
    await db .execute('''
    CREATE TABLE "notes"(
      "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
      "note" TEXT NOT NULL 
    )
    ''');
    print("Create DATABASE AND TABLE=======");
  }
  readData(String sql)async{
    Database? mydb = await db;
    List<Map> response =await mydb!.rawQuery(sql);
    return response ;

  }
  insertData(String sql)async{
    Database? mydb = await db;
    int response =await mydb!.rawInsert(sql);
    return response ;

  }
  updatetData(String sql)async{
    Database? mydb = await db;
    int response =await mydb!.rawDelete(sql);
    return response ;

  }
  deleteData(String sql)async{
    Database? mydb = await db;
    int response =await mydb!.rawDelete(sql);
    return response ;

  }
  mydeleteDatabase()async{
    String databasepath =await getDatabasesPath();
    String path = join(databasepath,"omar.db");
    await deleteDatabase(path);
  }
}