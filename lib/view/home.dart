import 'package:cherryticketmobile/view/eventall.dart';
import 'package:cherryticketmobile/view/list/berita_list.dart';
import 'package:cherryticketmobile/view/list/event_list_home.dart';
import 'package:cherryticketmobile/view/list/genre_list.dart';
import 'package:flutter/material.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
        backgroundColor: gray,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            color: gray,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/cherry_merah.png',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const AutoSizeText(
                      'Cherry Ticket',
                      style: TextStyle(
                          fontSize: 15,
                          color: cherry,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 18,
                    ),
                    AutoSizeText(
                      'News',
                      style: TextStyle(
                          fontSize: 15,
                          color: indigo,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const BeritaView(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 18,
                    ),
                    AutoSizeText(
                      'Genre',
                      style: TextStyle(
                          fontSize: 15,
                          color: indigo,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const GenreView(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 18,
                    ),
                    const AutoSizeText(
                      'Event',
                      style: TextStyle(
                          fontSize: 15,
                          color: indigo,
                          fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventAll()),
                      ),
                      child: const AutoSizeText(
                        'See All',
                        style: TextStyle(
                            fontSize: 10,
                            color: cherry,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                  ],
                ),
                const EventHomeView(),
              ],
            ),
          ),
        )));
  }
}
