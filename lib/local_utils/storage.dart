import 'package:hive_flutter/hive_flutter.dart';

 class storage{

   var box;
   // initialize hive in app
   storageInit() async {
     await Hive.initFlutter();
     box = Hive.box('storageCache');
   }

   // create data in  hive
   create(String key , dynamic data){
     box.put(key,data);
   }

   // updating data in  hive
   update(String key, dynamic data){
     box.put('$key',data);
   }

   // deleting data in hive
   delete(String key){
     box.delete(key);
   }

   //deleting all data in hive
   clearCache(){
     box.deleteAll();
   }

   // reading specified data from hive
   read(String what){
     return box.get(what);
   }



 }