import 'package:flutter/material.dart';
import 'package:jobforallmobile/store/auth_provider.dart';
import 'package:jobforallmobile/store/fetch_post.dart';
import 'package:jobforallmobile/widgets/component/loading.dart';
import 'package:jobforallmobile/widgets/signin_screen.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';


class AuthenticationWrapper extends StatefulWidget {
  AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {

  @override
  void initState() {
    context.read<AuthProvider>().loadFromPrefs(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(context.watch<AuthProvider>().loading){
      return const Loading();
    }else{
      if(context.watch<AuthProvider>().notify == false){
        return const SignInScreen();
      }else{
        return const HomeScreen();
      }
    }
  }
}