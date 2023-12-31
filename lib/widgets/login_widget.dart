import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterproject/repository/palette.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSignup = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Palette.color1,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            curve: Curves.easeIn,
            top: 180,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: isSignup ? 280 : 250,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignup = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !isSignup ? Colors.black : Colors.grey,
                              ),
                            ),
                            if (!isSignup)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Palette.color7,
                              ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignup = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'SIGNUP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSignup ? Colors.black : Colors.grey,
                              ),
                            ),
                            if (isSignup)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Palette.color7,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isSignup)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.account_circle,
                                  color: Palette.color7,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: 'User name',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Palette.color7,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Palette.color7,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (!isSignup)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.account_circle,
                                  color: Palette.color7,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: 'User name',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Palette.color7,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            curve: Curves.easeIn,
            top: isSignup ? 430 : 390,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Palette.color7,
                        Palette.color1,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 125,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignup ? 'or Signup with' : 'or Signin with'),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: const Size(155, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.blue),
                  icon: const Icon(Icons.add),
                  label: const Text('Google'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
