import 'package:attendance/source/blocs/login_bloc.dart';
import 'package:attendance/source/resources/pages/forgotpass_page.dart';
import 'package:attendance/source/resources/pages/home_page.dart';
import 'package:attendance/source/resources/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../fire_base/fire_base_auth.dart';
import '../features/remember.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FireAuth _firebaseAuth = FireAuth();
  final bool _onSuccess = false;
  LoginBloc bloc = LoginBloc();
  bool _showPass = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.indigo,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text('Attendance Checker App',
                    style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        color: Colors.white)),
              ),
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // const Text(
                      //   'Attendance Checker App',
                      //   style: TextStyle(
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.indigo),
                      // ),
                      const Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            StreamBuilder(
                              stream: bloc.emailStream,
                              builder: (context, snapshot) => TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  label: const Text(
                                    'Email:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                StreamBuilder(
                                  stream: bloc.passStream,
                                  builder: (context, snapshot) => TextField(
                                      controller: _passController,
                                      decoration: InputDecoration(
                                        errorText: snapshot.hasError
                                            ? snapshot.error.toString()
                                            : null,
                                        label: const Text(
                                          'Password:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      obscureText: !_showPass),
                                ),

                                // Text('SHOW',style: TextStyle(color: Colors.indigo),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: show,
                                        child: Text(
                                          !_showPass ? 'SHOW' : 'HIDE',
                                          style: const TextStyle(
                                              color: Colors.indigo,fontWeight: FontWeight.bold),
                                        )),
                                    // child: Icon(
                                    //   !_showPass
                                    //       ? CupertinoIcons.eye
                                    //       : CupertinoIcons.eye_slash_fill,
                                    //   color: Colors.indigo,
                                    //   size: 25,
                                    // )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.indigo,
                                      value: _rememberMe,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _rememberMe = value!;
                                        });
                                        RememberMeManager.setRememberMe(value!);
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassPage()));
                                  },
                                  child: const Text(
                                    'Forgot Password ?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _logIn();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Log In'),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const Text('Don\'t have an account yet ?'),
                                TextButton(
                                  onPressed: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()));
                                  },
                                  child: const Text(
                                    'Sign up',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void show() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void _logIn() async {
    if (bloc.isValidInfo(_emailController.text, _passController.text)) {
      String email = _emailController.text;
      String pass = _passController.text;
      User? user = await _firebaseAuth.signInWithEmailAndPassword(
          email, pass, _onSuccess);
      if (user != null) {
        if (_rememberMe) {
          await RememberMeManager.setRememberMe(true);
          await RememberMeManager.setCredentials(
              _emailController.text, _passController.text);
        } else {
          await RememberMeManager.setRememberMe(false);
          await RememberMeManager.clearCredentials();
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        bloc.isValidLogin(
            _emailController.text, _passController.text, _onSuccess);
      }
    }
  }

  void _loadRememberMe() async {
    bool rememberMe = await RememberMeManager.getRememberMe();
    setState(() {
      _rememberMe = rememberMe;
    });
    if (rememberMe) {
      String? username = await RememberMeManager.getUsername();
      String? password = await RememberMeManager.getPassword();
      if (username != null && password != null) {
        _emailController.text = username;
        _passController.text = password;
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
    bloc.dispose();
  }
}
