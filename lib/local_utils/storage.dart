import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

 class storage{
   var boxflu = Hive.box('storageCache');
   create(){
     box.put('',)
   }

   // deleting data in hive
   delete(){}

   //deleting all data in hive
   clearCache(){}

   // updating data in  hive
   update(){}

   // reading specified data from hive
   read(String what){
     box.get(what);
   }
 }