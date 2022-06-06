import 'package:cherryticketmobile/components/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/view/login.dart';
import 'package:cherryticketmobile/view/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cherry,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Image.asset('assets/images/get_started.png')),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const AutoSizeText(
                                    'Get Started!',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: cherry,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const AutoSizeText(
                                    "Welcome to Cherry Ticket if you have an account you can sign in if you don't sign up first. Best regards, Cherry Tickets.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: indigo,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Register()),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          primary: cherry,
                                          side: const BorderSide(
                                              width: 1.0, color: cherry),
                                        ),
                                        child: const Text("Sign Up"),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const SizedBox(height: 8.0),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: cherry),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()),
                                          );
                                        },
                                        child: const Text("Sign In"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
