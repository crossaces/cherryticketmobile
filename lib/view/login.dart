import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:cherryticketmobile/model/auth_model.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:cherryticketmobile/view/navigation.dart';
import 'package:cherryticketmobile/view/register.dart';
import 'package:cherryticketmobile/view/resend.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidePassword = true;
  final _form = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  String token = "";
  bool isApiCallProcess = false;
  LoginRequestModel requestModel;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    requestModel = LoginRequestModel();
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
                      child: Image.asset('assets/images/login.png')),
                ),
              ),
              Expanded(
                flex: !isKeyboard ? 2 : 1,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    decoration: const BoxDecoration(
                        color: gray,
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
                                    'Login Now',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: cherry,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const AutoSizeText(
                                    "Please enter the detail below to continue",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: indigo,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                            obscureText:
                                                _isHidePassword ? true : false,
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
                                              prefixIcon: const Icon(Icons.lock,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                .login(requestModel)
                                                .then((value) {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
                                              if (value['message'] ==
                                                  'Please Verify Email') {
                                                final snackBar = SnackBar(
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.red[800],
                                                  content: Text(
                                                      "${value['message']}"),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                savePref(value['user']['id']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Resend()));
                                              } else {
                                                if (value['message'] !=
                                                    'Login Failed') {
                                                  if (value['user']['role'] ==
                                                      'Peserta') {
                                                    if (value['message'] ==
                                                        'Login Successfully') {
                                                      APIService apiService =
                                                          APIService();
                                                      apiService.updateToken(
                                                          value['user']
                                                              ['ID_PESERTA'],
                                                          token,
                                                          value['token']);
                                                      final snackBar = SnackBar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.green[800],
                                                        content: Text(
                                                            "${value['message']}"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                      saveLogin(
                                                          value['user']
                                                              ['ID_USER'],
                                                          value['user']
                                                              ['ID_PESERTA'],
                                                          value['token']);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const NavigationBottom()));
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
                                                  } else {
                                                    final snackBar = SnackBar(
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.red[800],
                                                      content: const Text(
                                                          "Only Customer Account"),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                } else {
                                                  final snackBar = SnackBar(
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        Colors.red[800],
                                                    content: Text(
                                                        "${value['message']}"),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              }
                                            });
                                          }
                                        },
                                        child: const Text("Sign In"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const AutoSizeText(
                                        "Don’t have an account?",
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
                                                        const Register()),
                                              ),
                                          child: const AutoSizeText(
                                            " Sign Up",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: cherry,
                                                fontWeight: FontWeight.w800),
                                          )),
                                    ],
                                  ),
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

savePref(int id) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('iduser', id);
}

saveLogin(int id, int idpeserta, String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('iduser', id);
  prefs.setInt('idpeserta', idpeserta);
  prefs.setString('token', token);
}
