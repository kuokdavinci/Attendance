import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../fire_base/fire_base_auth.dart';


class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Container(
          width: MediaQuery
              .sizeOf(context)
              .width,
          height: MediaQuery
              .sizeOf(context)
              .height,
          color: Colors.indigo,
          child:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0,80.0,5.0,30.0),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 75.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Forgot Password',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                        ),
                        const SizedBox(height: 15,),
                        const Text('Enter email address to reset your password'),
                        const SizedBox(height: 20,),
                         TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            label: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),

                          ),
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed:() {
                          _resetPass();
                          }
                        ,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            padding: const EdgeInsets.all(8.0),
                              child: const Text("Submit",textAlign: TextAlign.center,)), )
                      ],
                      ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

  void _resetPass() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text.trim());
      showEmailSent();
    } catch (e){
      showError();
    }
  }
  void showEmailSent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.indigo,),
            SizedBox(width: 5,),
            Text('Sent successfully! Check your email', style: TextStyle(fontSize: 18,
                color: Colors.indigo,
                fontStyle: FontStyle.italic),),
          ],
        ),
      ),
    );
  }
  void showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          children: [
            Icon(Icons.cancel, color: Colors.indigo,),
            SizedBox(width: 5,),
            Text('Your email doesn\'t exist !', style: TextStyle(fontSize: 18,
                color: Colors.indigo,
                fontStyle: FontStyle.italic),),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

