import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobforallmobile/model/jobseeker_profile.dart';
import 'package:jobforallmobile/model/signup_response_model.dart';
import 'package:jobforallmobile/model/token_model.dart';
import 'package:jobforallmobile/model/user_account_model.dart';
import 'package:jobforallmobile/widgets/auth_wrapper.dart';
import 'package:jobforallmobile/widgets/wellcome_screen.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile_model.dart';
import '../model/signin_model.dart';
import '../model/signup_model.dart';
import '../widgets/signin_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool isComplete = false;
  bool loading = true;
  JobseekerProfile? profile;

  bool _notify = false;
  UserProfile? account;
  bool get notify => _notify;

  set notify(bool value) {
    _notify = value;
  }

  String value = "key";
  int id = 0;
  SharedPreferences? _prefs;
  String? token;

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  _saveToPrefs(k) async {
    await _initPrefs();
    _prefs!.setString(value, k);
    notifyListeners();
  }

  loadFromPrefs(context) async {
    await _initPrefs();
    token = _prefs!.getString(value) ?? "";
    if(token==""){
      loading = false;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignInScreen())
      );
    }else{
      Map<String, dynamic> payload = Jwt.parseJwt(token!);
      id = payload['user_id'];
      ReadAccount(token,id);
      notifyListeners();
    }
  }

  _removeFromPrefs() async{
    await _initPrefs();
    _prefs!.remove(value);
    notifyListeners();
  }

  Future signOut(context) async{
    await _removeFromPrefs();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SignInScreen())
    );
  }

  Future<http.Response?> signup(SignUpBody data,context) async {
    http.Response? response;

    try {
      loading = true;
      notifyListeners();
      response =
      await http.post(
          Uri.parse("http://10.0.2.2:8000/api/user/register/jobseeker/"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(data.toJson()));
          if (response.statusCode == 200) {
            final user = signupResponseFromJson(response.body);
            id = user.user.id;
            loading = false;
            print("created successfully");
            notifyListeners();
          }else{
            print("thre is stm");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wellcome())
            );
            loading = false;
            notifyListeners();
          }
    } catch (e) {
      loading = false;
      notifyListeners();
      print("jon error" + e.toString());
    }

    loading = false;
    notifyListeners();
    return response;
  }


  Future<http.Response?> signin(SignInBody data,context) async {
    http.Response? response;

    try {
      loading = true;
      notifyListeners();
      response =
      await http.post(
          Uri.parse("http://10.0.2.2:8000/api/token/"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body:jsonEncode(data.toJson())
      );
      if (response.statusCode == 200) {
        final token = tokenResponseFromJson(response.body);
        _saveToPrefs(token.access);
        loading = false;
        _notify = true;
        showSnackBar(context, "loged in successfuly");
        print("Loged in successfuly");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AuthenticationWrapper()),
        );
        notifyListeners();
      }else{
        print("thre is stm");

        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print("jon error" + e.toString());
    }

    loading = false;
    notifyListeners();
    return response;
  }

  Future<http.Response?> EditProfileData(ProfileBody data,context) async {
    http.Response? response;
    loading = true;
    notifyListeners();

    try {
      print("your id is $id");
      response =
      await http.put(
          Uri.parse("http://10.0.2.2:8000/api/user/jobseeker/profile/edit/$id"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(data.toJson()));
      if (response.statusCode == 200) {
        print("profile created");
        showSnackBar(context, "profile created");
        loading = false;
        notifyListeners();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignInScreen())
        );
      }else
        {
          loading = false;
          notifyListeners();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Wellcome())
          );
          print("you have some error");
        }

    } catch (e) {
      loading = false;

      notifyListeners();
      print("jon error" + e.toString());
    }

    loading = false;
    notifyListeners();
    return response;
  }

  Future<http.Response?> ReadProfileData(context) async {
    http.Response? response;
    print("thi is $id");
    try {
      response =
      await http.get(
          Uri.parse("http://10.0.2.2:8000/api/user/jobseeker/profile/$id"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          });
      if (response.statusCode == 200) {
        loading = false;
        _notify = true;
        final result = jobseekerProfileFromJson(response.body);
        profile = result;

        print("sucess profile");
        notifyListeners();

      }else
      {
        loading = false;
        notifyListeners();
        print("you have some error");
      }

    } catch (e) {
      loading = false;

      notifyListeners();
      print("jon error " + e.toString());
    }

    loading = false;
    notifyListeners();
    return response;
  }

  Future<http.Response?> ReadAccount(token,  id) async {
    http.Response? response;
    print(id);
    try {
      response =
      await http.get(
          Uri.parse("http://10.0.2.2:8000/api/user/$id"),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
          if (response.statusCode == 200) {
            loading = false;
            _notify = true;
            final result = userProfileFromJson(response.body);
            account = result;
            id = account!.user.id;
            print("sucess");
            notifyListeners();
          }else
          {
            _notify = false;
            loading = false;
          }
    } catch (e) {
      loading = false;
      _notify = false;
      notifyListeners();
      print("jon error" + e.toString());
    }

    notifyListeners();
    return response;
  }

  void initialValues(){
    loading = true;
    notifyListeners();
  }

}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

