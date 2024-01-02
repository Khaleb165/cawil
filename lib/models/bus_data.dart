import 'package:flutter/material.dart';

class BusData extends ChangeNotifier{
  String toTextField = '';
  String fromTextField = '';
  DateTime selectedDate = DateTime.now();

  void updateToTextField(String newText){
    toTextField = newText;
    notifyListeners();
  }
  
  void updateFromTextField(String newText){
    fromTextField = newText;
    notifyListeners();
  }

  void updateSelectedDate(DateTime date){
    selectedDate = date;
    notifyListeners();
  }
}