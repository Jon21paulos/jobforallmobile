import 'package:flutter/material.dart';
import 'package:jobforallmobile/store/apply/apply_provider.dart';
import 'package:jobforallmobile/store/apply/delete_applier.dart';
import 'package:jobforallmobile/store/auth_provider.dart';
import 'package:jobforallmobile/store/apply/fetch_applier.dart';
import 'package:jobforallmobile/store/fetch_post.dart';
import 'package:jobforallmobile/widgets/auth_wrapper.dart';
import 'package:jobforallmobile/widgets/signup_screen.dart';
import 'package:jobforallmobile/widgets/wellcome_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AuthProvider()),
    ChangeNotifierProvider(create: (_)=>FetchPost()),
    ChangeNotifierProvider(create: (_)=>ApplyProvider()),
    ChangeNotifierProvider(create: (_)=>FetchApplier()),
    ChangeNotifierProvider(create: (_)=>DeleteApplier()),

  ],
      child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Job for all',
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(),
    );
  }
}
