import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth_email/main.dart';
import 'package:flutter/material.dart';

// This is home page after sign in or sign up page this will appear
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // user shows currently login ot sign up user
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Signed In as',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8,),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.arrow_back, size:32),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              // Signed out
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      )
    );
  }
}















