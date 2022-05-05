import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobforallmobile/model/apply_post_model.dart';

class ApplyProvider with ChangeNotifier {
  bool loading = true;

  Future<http.Response?> apply(ApplyPost data,context) async {
    http.Response? response;
    try {
      response =
      await http.post(
          Uri.parse("http://10.0.2.2:8000/applier/add"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body:jsonEncode(data.toJson())
      );
      if (response.statusCode == 200) {
        showSnackBar(context, "you applied successfuly");
      }else{
        print("thre is stm");
        showSnackBar(context, response.body);
        print(response.body);
        print(data.ApplierId);
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      showSnackBar(context, "something went wrong");
      print("jon error" + e.toString());
    }

    loading = false;
    notifyListeners();
    return response;
  }

}
void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}