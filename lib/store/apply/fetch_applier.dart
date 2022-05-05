import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/applied_model.dart';

class FetchApplier with ChangeNotifier {

  List<ApplierData> applier = [];
  bool _notify = false;
  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  String _errorMessage = '';
  int currentPage = 1;

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
    fetchApplier(token,applierId);
    notifyListeners();
  }

  bool get message => _message;

  bool get notify => _notify;

  String get errorMessage => _errorMessage;

  Future<void> fetchApplier(token, applierId) async {
    try {
      String url = 'http://10.0.2.2:8000/applier/?ApplierId=$applierId';
      print(url);
      final response = await get(Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final result = applierDataFromJson(response.body);
        applier = result;

        _notify = true;
        _loading = false;
        print("succesfull");
        notifyListeners();
      }
      if (response.statusCode == 401) {
        _notify = false;
        _loading = false;
        applier = [];
        _error = true;
        print("un authorized");
      }
    } catch (e) {
      _notify = false;
      _error = true;
      applier = [];
      _loading = false;
      print('sorry error occured');
      print(e);
    }
    notifyListeners();
  }


  void initialValues() {
    applier = [];
    currentPage = 1;
    _message = true;
    _error = false;
    _notify = false;
    _loading = true;
    notifyListeners();
  }
}