import 'package:cherryticketmobile/model/berita_model.dart';
import 'package:cherryticketmobile/providerAPI/berita.dart';
import 'package:cherryticketmobile/view/getstarted.dart';
import 'package:cherryticketmobile/view/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<BeritaAPI>(create: (_) => BeritaAPI()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: token == null
              ? const GetStartedScreen()
              : const NavigationBottom())));
}
