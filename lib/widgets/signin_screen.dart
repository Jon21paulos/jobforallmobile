import 'package:flutter/material.dart';

import 'component/custom_button.dart';
import 'component/email_signin.dart';
import 'component/signin_google.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool signUpwithgoogle = false;
  void changeState(){
    setState(() {
      signUpwithgoogle = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 10),

                if(!isKeyboard)
                  Container(
                    height: 150,
                    alignment: Alignment.center, // This is needed
                    child: Image.asset(
                      "lib/assets/computer.png",
                      fit: BoxFit.contain,
                      width: 300,
                    ),
                  ),

                const SizedBox(height: 10),

                signUpwithgoogle?  const SignInGoogleScreen():

                Column(
                  children: [

                    if(!isKeyboard) buttonItem(context,changeState),

                    const SizedBox(height: 10),

                    if(!isKeyboard) Center(
                      child: Text(
                        "or",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                    ),

                    const EmailSignIn(),

                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}
