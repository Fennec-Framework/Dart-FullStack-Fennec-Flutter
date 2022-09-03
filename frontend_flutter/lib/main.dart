import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/pages/chat_list.dart';
import 'package:frontend_flutter/repositories/api_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('SecureBox');
  runApp(const MyApp());
}

final Dio dio = Dio();
final box = Hive.box("SecureBox");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: const ChatList(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: loading
            ? const Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextField(
                      controller: username,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextField(
                      controller: email,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextField(
                      controller: password,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text('SignUp'),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        ApiRepository apiRepository = ApiRepository();
                        final result = await apiRepository.signup(
                            username.text, email.text, password.text, context);
                        setState(() {
                          loading = false;
                        });
                        if (result != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                        );
                      },
                      child: const Text('to Sign In')),
                ]),
              ));
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState1();
  }
}

class _SignInPageState1 extends State<SignInPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: loading
            ? const Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextField(
                      controller: email,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextField(
                      controller: password,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text('SignIn'),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        var data = {
                          'email': email.text,
                          'password': password.text
                        };
                        try {
                          Response userData = await dio.post(
                              'http://192.168.0.116:8080/auth/signin',
                              data: data);
                          const snackBar = SnackBar(
                            content: Text('user sucessful logged in'),
                          );

                          await box.put('token', userData.data['token']);

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } on DioError catch (e) {
                          var snackBar = SnackBar(
                              content: Text(
                            e.response!.data.toString(),
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),
                ]),
              ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: ElevatedButton(
            child: const Text('show Profile'),
            onPressed: () async {
              var token = await box.get('token');
              try {
                Response userData = await dio.post(
                    'http://192.168.0.116:8080/auth/getProfile',
                    data: {'token': token});

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Show Profile'),
                      children: <Widget>[
                        Text(
                            '  userName:' + userData.data['user']['user_name']),
                        Text('  email:' + userData.data['user']['email']),
                      ],
                    );
                  },
                );
              } on DioError catch (e) {
                var snackBar = SnackBar(
                    content: Text(
                  e.response!.data.toString(),
                ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          ),
        ));
  }
}
