import 'package:cherryticketmobile/providerAPI/auth.dart';
import 'package:flutter/material.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'login.dart';

class Resend extends StatefulWidget {
  const Resend({Key key}) : super(key: key);

  @override
  State<Resend> createState() => _ResendState();
}

class _ResendState extends State<Resend> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var numberController = TextEditingController();
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Visibility(
                visible: !isKeyboard,
                child: Expanded(
                  flex: !isKeyboard ? 1 : 1,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Image.asset('assets/images/register.png')),
                ),
              ),
              Expanded(
                flex: !isKeyboard ? 2 : 1,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const AutoSizeText(
                                      'Ooopss...',
                                      style: TextStyle(
                                          fontSize: 45,
                                          color: indigo,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const AutoSizeText(
                                      "Your account is not verified yet. Please verify your email by click on a link in your email",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: cherry,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const AutoSizeText(
                                      "Doesn’t receive email from us? Please click the button below to resend verification email.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: cherry,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 8.0),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: cherry),
                                          onPressed: () {
                                            setState(() {
                                              isApiCallProcess = true;
                                            });

                                            APIService apiService =
                                                APIService();

                                            apiService.resend().then((value) {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });

                                              final snackBar = SnackBar(
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.green[800],
                                                  content: Text(
                                                      "${value['message']}"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          },
                                          child: const Text("Resend"),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const AutoSizeText(
                                          "Already verified?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: indigo,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        InkWell(
                                            onTap: () =>
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login()),
                                                ),
                                            child: const AutoSizeText(
                                              " Sign in",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: cherry,
                                                  fontWeight: FontWeight.w800),
                                            )),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
