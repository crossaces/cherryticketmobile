import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:cherryticketmobile/model/auth_model.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var passwordlamaController = TextEditingController();
  var passwordbaruController = TextEditingController();
  var passwordconfirmController = TextEditingController();
  bool _isHidePassword = true;
  bool _isHidePassword1 = true;
  bool _isHidePassword2 = true;
  bool isApiCallProcess = false;
  PasswordRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = PasswordRequestModel();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void _togglePasswordVisibility1() {
    setState(() {
      _isHidePassword1 = !_isHidePassword1;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _isHidePassword2 = !_isHidePassword2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      title: const Text(
        'Change Password',
        textAlign: TextAlign.center,
        style: TextStyle(color: indigo),
      ),
      content: Form(
        key: globalFormKey,
        child: Container(
          color: white,
          height: 260,
          child: Column(
            children: [
              const Text('Minimal 8 Character',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54)),
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
                controller: passwordlamaController,
                onChanged: (input) => requestModel.passwordlama = input,
                autofocus: false,
                cursorColor: Colors.black,
                obscureText: _isHidePassword ? true : false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility();
                    },
                    child: Icon(
                      _isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePassword ? indigo : cherry,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0)),
                  hintText: 'Last Password',
                  labelStyle: const TextStyle(color: Color(0xFFa67717)),
                  prefixIcon: const Icon(
                    Icons.shield_outlined,
                    color: indigo,
                  ),
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
                controller: passwordbaruController,
                onChanged: (input) => requestModel.password = input,
                autofocus: false,
                obscureText: _isHidePassword1 ? true : false,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility1();
                    },
                    child: Icon(
                      _isHidePassword1
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: _isHidePassword1 ? indigo : cherry,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0)),
                  hintText: 'New Password',
                  labelStyle: const TextStyle(color: Color(0xFFeca81e)),
                  prefixIcon:
                      const Icon(Icons.lock_open_outlined, color: indigo),
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
                onChanged: (input) => requestModel.cpassword = input,
                controller: passwordconfirmController,
                autofocus: false,
                obscureText: _isHidePassword2 ? true : false,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility2();
                    },
                    child: Icon(
                      _isHidePassword2
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: _isHidePassword2 ? indigo : cherry,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0)),
                  hintText: 'Confirm Password',
                  labelStyle: const TextStyle(color: Color(0xFFeca81e)),
                  prefixIcon: const Icon(Icons.lock_outlined, color: indigo),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.green))),
            TextButton(
              onPressed: () {
                setState(() {
                  if (globalFormKey.currentState.validate()) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    APIService apiService = APIService();
                    apiService.gantipassword(requestModel).then((value) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value['message'] == 'Change Password Successfully') {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green[800],
                          content: Text("${value['message']}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      } else {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          content: Text("${value['message']}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }
                });
              },
              child: const Text(
                'Change',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        )
      ],
    );
  }
}
