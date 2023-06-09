import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
//import 'package:firebase_auth_email/main.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils.dart';
import 'ForgotPasswordPage.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20),
            child: Text(
              'Login page',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          SizedBox(height: 100,),
          TextField(
            controller: emailController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 4),
          TextField(
            controller: passwordController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.lock_open),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn ,
          ),
          SizedBox(height: 24,),
          GestureDetector(
            child: Text(
              'Forot Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
              ),
            ),
            // Navigate to Forgot Password screen
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgotPasswordPage(),
            )),
          ),
          SizedBox(height: 16,),
          RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black,fontSize: 20),
                text: 'No account?  ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                       ..onTap = widget.onClickedSignUp,
                    text: 'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
           ),
        ],
      ),
    );
  }
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route)=> route.isFirst);
  }
}














