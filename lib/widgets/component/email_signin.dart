import 'package:flutter/material.dart';
import 'package:jobforallmobile/store/auth_provider.dart';
import 'package:provider/src/provider.dart';

import '../../model/signin_model.dart';
import '../signup_screen.dart';
import 'custom_textfield.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  @override
  State<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();

  final  usernameController= TextEditingController();
  final  passwordController = TextEditingController();

  bool signUp = false;
  bool isPasswordNotVisible = true;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() =>{setState(() {
    })});
  }

  void changeVisibility(){
    setState(() {
      isPasswordNotVisible = !isPasswordNotVisible;
    });
  }

  void Clear(){
    usernameController.clear();
    passwordController.clear();
  }

  Future<void> _signin() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    SignInBody signInBody = SignInBody(
        username: username, password: password);

    var provider = Provider.of<AuthProvider>(context, listen: false);
    await provider.signin(signInBody,context);
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: [

          const SizedBox(height: 20),

          customNameTextField(usernameController, context),

          const SizedBox(height: 20),

          customPasswordTextField(passwordController,context,isPasswordNotVisible,changeVisibility),

          const SizedBox(height: 20),

          // Text(context.watch<AuthenticationService>().errorMessage,
          //   style: const TextStyle(color: Colors.red,fontSize: 17),
          // ),

          const SizedBox(height: 10),

          context.watch<AuthProvider>().loading?

          const CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(Colors.blue),
          ):

          MaterialButton(
            onPressed: () {
              // context.read<AuthenticationService>().initialValues();
              if (_formKey.currentState!.validate()) {
                  _signin();
              }
            },
            height: 40,
            minWidth: double.infinity,
            color: Theme
                .of(context)
                .primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
                "Sign In",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6
            ),

          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen())
              );
            },
            child:  Text(
              "Create an account",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}