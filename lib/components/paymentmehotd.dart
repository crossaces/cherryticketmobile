import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/view/transactionpayment_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key key}) : super(key: key);

  @override
  _PaymentMethod createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PaymentMethod> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      content: Container(
          color: white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Bank Transfer',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cherry, fontWeight: FontWeight.w600)),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionPayment(
                            "https://www.yayasansimetri.or.id/wp-content/uploads/2021/03/Logo-BCA-blue-A4.png",
                            "032 900 977 9",
                            "BCA Transfer")),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      color: white,
                      child: Image.network(
                        'https://www.yayasansimetri.or.id/wp-content/uploads/2021/03/Logo-BCA-blue-A4.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('BCA Transfer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: indigo,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ],
                ),
              )
            ],
          )),
    );
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
