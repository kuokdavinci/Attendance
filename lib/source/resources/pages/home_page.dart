import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Column(
            children: [
              const Text('HOMEPAGE'),
              const SizedBox(height: 20,),
              TextButton(onPressed: _signOut
                  , child: const Text('Sign Out'))
            ],
          )),
    );
  }
  void _signOut(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}