import 'package:flutter/material.dart';
import 'package:jobforallmobile/widgets/signin_screen.dart';
import 'package:jobforallmobile/widgets/signup_screen.dart';

class Wellcome extends StatelessWidget {
  const Wellcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hello"),
      ),
      body:Column(
        children: [
          ElevatedButton(
              onPressed:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen())
                );
              },
              child: Text("SignIn")
          ),

          ElevatedButton(
              onPressed:() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen())
                );
              },
              child: Text("SignUp")
          ),
        ],
      )
    );
  }
}
