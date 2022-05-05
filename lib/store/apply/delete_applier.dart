import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/applied_model.dart';

class DeleteApplier with ChangeNotifier {

  bool _notify = false;
  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  String _errorMessage = '';

  bool _message = true;
  bool _error = false;
  String value = "key";

  bool get error => _error;

  set error(bool value) {
    _error = value;
  }

  String? token;

  SharedPreferences? _prefs;

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  loadFromPrefs(applierId) async {
    await _initPrefs();
    token = _prefs!.getString(value) ?? "";
    // deleteApplier(token,applierId);
    notifyListeners();
  }

  Future<void> deleteApplier(applyId) async {
    try {
      String url = 'http://10.0.2.2:8000/applier/delete/$applyId';
      print(url);
      final response = await get(Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        _notify = true;
        _loading = false;
        print("succesfully deleted");
        notifyListeners();
      }
      if (response.statusCode == 401) {
        _notify = false;
        _loading = false;
        _error = true;
        print("un authorized");
      }
    } catch (e) {
      _notify = false;
      _error = true;
      _loading = false;
      print('sorry error occured');
      print(e);
    }
    notifyListeners();
  }

  bool get message => _message;

  bool get notify => _notify;

  String get errorMessage => _errorMessage;



  void initialValues() {

    _message = true;
    _error = false;
    _notify = false;
    _loading = true;
    notifyListeners();
  }
}