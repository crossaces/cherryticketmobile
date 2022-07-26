import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/berita_api.dart';
import 'package:cherryticketmobile/providerAPI/form_pendaftaran_api.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/providerAPI/kota_api.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/providerAPI/genre_api.dart';
import 'package:cherryticketmobile/providerAPI/peserta_api.dart';
import 'package:cherryticketmobile/providerAPI/transaksi_api.dart';
import 'package:cherryticketmobile/view/getstarted.dart';
import 'package:cherryticketmobile/view/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Cherry Ticket', 'Cherry Ticket Notification',
    importance: Importance.high, playSound: true, showBadge: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  String token = prefs.getString('token');
  runApp(MyApp(token));
}

class MyApp extends StatefulWidget {
  final String token;
  const MyApp(this.token, {Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelShowBadge: true,
                color: cherry,
                playSound: true,
                icon: '@mipmap/launcher_icon',
              ),
            ));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BeritaAPI>(
            create: (_) => BeritaAPI(),
          ),
          ChangeNotifierProvider<GenreAPI>(create: (_) => GenreAPI()),
          ChangeNotifierProvider<EventAPI>(create: (_) => EventAPI()),
          ChangeNotifierProvider<KotaAPI>(create: (_) => KotaAPI()),
          ChangeNotifierProvider<PesertaAPI>(create: (_) => PesertaAPI()),
          ChangeNotifierProvider<FormPendaftaranAPI>(
              create: (_) => FormPendaftaranAPI()),
          ChangeNotifierProvider<JawabanPendaftaran>(
              create: (_) => JawabanPendaftaran()),
          ChangeNotifierProvider<TransaksiApi>(create: (_) => TransaksiApi()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: widget.token == null
                ? const GetStartedScreen()
                : const NavigationBottom()));
  }
}
