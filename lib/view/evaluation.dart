import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formevaluasi_model.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:cherryticketmobile/providerAPI/form_evaluasi_api.dart';
import 'package:cherryticketmobile/providerAPI/form_pendaftaran_api.dart';
import 'package:cherryticketmobile/view/list/evaluation_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EvaluationScreen extends StatefulWidget {
  final int idpendaftaran;
  const EvaluationScreen(this.idpendaftaran, {Key key}) : super(key: key);

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gray,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                backgroundColor: indigo,
                pinned: true,
                title: Text("Evaluation"),
              ),
              SliverList(
                delegate: SliverChildListDelegate([const EvaluationView()]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: indigo,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.feedback_rounded,
                  color: indigo,
                  size: 15.0,
                ),
                label: const AutoSizeText(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: indigo),
                  maxLines: 1,
                ),
                onPressed: () {
                  APIService apiService = APIService();
                  apiService
                      .evaluation(
                          Provider.of<FormEvaluasiAPI>(context, listen: false)
                              .items
                              .datapertanyaan,
                          Provider.of<FormEvaluasiAPI>(context, listen: false)
                              .items
                              .idformevaluasi,
                          widget.idpendaftaran)
                      .then((value) {
                    if (value['message'] == 'Send Your Feedback Successfully') {
                      final snackBar = SnackBar(
                        duration: const Duration(milliseconds: 2000),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green[800],
                        content: Text("${value['message']}"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        duration: const Duration(milliseconds: 2000),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red[800],
                        content: Text("${value['message']}"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  primary: gray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
