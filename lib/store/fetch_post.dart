import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:jobforallmobile/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchPost with ChangeNotifier {

  List<Result> posts = [];
  bool _notify = false;
  bool _loading = true;
  String path = '';


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

  int totalPages = 2;

  String? token;

  SharedPreferences? _prefs;

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await _initPrefs();
    token = _prefs!.getString(value) ?? "";
    path = '';
    fetchPost(token);
    notifyListeners();
  }

  filterFromPosts(city,deadline,jobtime,jobtype,salary,title,user) async {
    path = 'City=$city&Deadline=$deadline&Description=&Jobtime=$jobtime&Jobtype=$jobtype&Salary=$salary&Title=$title&user=$user';
    initialValues();
    fetchPost(token);
  }

  searchFromPosts(search) async {
    path = 'search=$search';
    fetchPost(token);
  }

  bool get message => _message;

  bool get notify => _notify;

  String get errorMessage => _errorMessage;

  Future<void>  fetchPost(token) async {
   if(currentPage > totalPages){
     _message = false;
     notifyListeners();
   }else{
     try{
       String url = 'http://10.0.2.2:8000/job/?p=$currentPage&$path';
       print(url);
       final response = await get(Uri.parse(url),
         headers: {
           HttpHeaders.authorizationHeader: 'Bearer $token',
         },
       );
       if (response.statusCode == 200) {
         final result = postDataFromJson(response.body);
         posts.addAll(result.results);
         print(result);
         currentPage++;

         totalPages = (result.count/10).ceil();
         _notify = true;
         _loading = false;
         print("succesfull");
         notifyListeners();
       }
       if (response.statusCode == 401) {
         _notify = false;
         _loading = false;
         posts = [];
         _error = true;
         print("un authorized");
       }

     }catch(e){
       _notify = false;
       _error = true;
       posts = [];
       _loading = false;
       print('sorry error occured');
       print(e);
     }
     notifyListeners();
   }
  }

  void initialValues() {
      posts = [];
     currentPage = 1;
     _message = true;
     _error = false;
     _notify = false;
     _loading = true;
    notifyListeners();
  }
}