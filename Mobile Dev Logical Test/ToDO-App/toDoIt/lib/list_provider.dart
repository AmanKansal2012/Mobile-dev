import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProvider extends ChangeNotifier{
  List<String> _todo=[];
  List<String> get toDo => _todo;
  void updateUI() {
    notifyListeners();
  }
  void getList(List value) {
      _todo=value;
      updateUI();
  }

}