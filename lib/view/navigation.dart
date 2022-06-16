import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/providerAPI/berita_api.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/providerAPI/genre_api.dart';
import 'package:cherryticketmobile/providerAPI/kota_api.dart';
import 'package:cherryticketmobile/view/event.dart';
import 'package:cherryticketmobile/view/home.dart';
import 'package:cherryticketmobile/view/profile.dart';
import 'package:cherryticketmobile/view/transaction.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key key}) : super(key: key);

  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _selectedIndex = 0;
  List _listScreens;

  @override
  void initState() {
    super.initState();
    Provider.of<GenreAPI>(context, listen: false).fetch();
    Provider.of<BeritaAPI>(context, listen: false).fetchberita();
    Provider.of<EventAPI>(context, listen: false).fetch();
    Provider.of<KotaAPI>(context, listen: false).fetch();
    setState(() {
      _listScreens = [
        const HomeScreen(),
        const EventScreen(),
        const TransactionScreen(),
        const ProfileScreen(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listScreens[_selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          selectedItemBorderColor: gray,
          barBackgroundColor: indigo,
          selectedItemBackgroundColor: cherry,
          selectedItemIconColor: white,
          selectedItemLabelColor: white,
        ),
        selectedIndex: _selectedIndex,
        onSelectTab: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.dashboard,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.event_note_outlined,
            label: 'Event',
          ),
          FFNavigationBarItem(
            iconData: Icons.credit_card,
            label: 'Transaction',
          ),
          FFNavigationBarItem(
            iconData: Icons.account_circle,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
