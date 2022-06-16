import 'package:cherryticketmobile/model/auth_model.dart';
import 'package:cherryticketmobile/providerAPI/auth_api.dart';
import 'package:cherryticketmobile/view/resend.dart';
import 'package:flutter/material.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isHidePassword = true;
  final _form = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var numberController = TextEditingController();
  bool isApiCallProcess = false;
  RegisterRequestModel requestModel;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    requestModel = RegisterRequestModel();
    setState(() {
      requestModel.role = "Peserta";
    });

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
                                      'Register Now!',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: cherry,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const AutoSizeText(
                                      "Please enter the detail below continue",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: indigo,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Form(
                                        key: _form,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator: (value) {
                                                RegExp regExp = RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                                if (value.isEmpty) {
                                                  return 'This field must be fill';
                                                } else if (!regExp
                                                    .hasMatch(value)) {
                                                  return "Enter a valid e-mail address";
                                                }
                                                return null;
                                              },
                                              controller: emailController,
                                              onChanged: (input) =>
                                                  requestModel.email = input,
                                              autofocus: false,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10.0),
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                hintText: 'Email',
                                                labelStyle: const TextStyle(
                                                    color: divider),
                                                prefixIcon: const Icon(
                                                    Icons.email,
                                                    color: cherry),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                RegExp regExp = RegExp(
                                                    r'^(?:[+0]8)?[0-9]{10,11}$');
                                                if (value.isEmpty) {
                                                  return 'This field must be fill';
                                                } else if (!regExp
                                                    .hasMatch(value)) {
                                                  return "Enter a valid number phone";
                                                }
                                                return null;
                                              },
                                              controller: numberController,
                                              onChanged: (input) =>
                                                  requestModel.nohp = input,
                                              autofocus: false,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10.0),
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                hintText: 'Number Phone',
                                                labelStyle: const TextStyle(
                                                    color: divider),
                                                prefixIcon: const Icon(
                                                    Icons.phone,
                                                    color: cherry),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'This field must be fill';
                                                } else if (value.length < 8) {
                                                  return "Password minimal 8 Character";
                                                }
                                                return null;
                                              },
                                              controller: passController,
                                              onChanged: (input) =>
                                                  requestModel.password = input,
                                              autofocus: false,
                                              obscureText: _isHidePassword
                                                  ? true
                                                  : false,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    _togglePasswordVisibility();
                                                  },
                                                  child: Icon(
                                                    _isHidePassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: _isHidePassword
                                                        ? indigo
                                                        : cherry,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10.0),
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                hintText: 'Password',
                                                labelStyle: const TextStyle(
                                                    color: divider),
                                                prefixIcon: const Icon(
                                                    Icons.lock,
                                                    color: cherry),
                                              ),
                                            ),
                                          ],
                                        )),
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
                                            if (_form.currentState.validate()) {
                                              setState(() {
                                                isApiCallProcess = true;
                                              });

                                              APIService apiService =
                                                  APIService();
                                              apiService
                                                  .register(requestModel)
                                                  .then((value) {
                                                setState(() {
                                                  isApiCallProcess = false;

                                                  if (value['message'] ==
                                                      'Registered Successfully') {
                                                    final snackBar = SnackBar(
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.green[800],
                                                      content: Text(
                                                          "${value['message']}"),
                                                    );
                                                    savePref(
                                                        value['user']['id']);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Resend()));
                                                  } else {
                                                    if (value['message']
                                                            ['email'] !=
                                                        null) {
                                                      final snackBar = SnackBar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.red[800],
                                                        content: Text(
                                                            "${value['message']['email'][0]}"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    } else {
                                                      final snackBar = SnackBar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.red[800],
                                                        content: Text(
                                                            "${value['message']}"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    }
                                                  }
                                                });
                                              });
                                            }
                                          },
                                          child: const Text("Sign Up"),
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
                                          "Already have an account?",
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

savePref(int id) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('iduser', id);
}
