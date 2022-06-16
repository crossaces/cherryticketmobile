import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/view/list/item/event_item_home.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventHomeView extends StatefulWidget {
  const EventHomeView({Key key}) : super(key: key);

  @override
  _EventHomeViewState createState() => _EventHomeViewState();
}

class _EventHomeViewState extends State<EventHomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const EventHomeList();
  }
}

class EventHomeList extends StatelessWidget {
  const EventHomeList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventData = Provider.of<EventAPI>(context);
    List<Event> event = Provider.of<EventAPI>(context).genre == 'All'
        ? searchpublic(eventData.items)
        : _performSearch(eventData.items, Provider.of<EventAPI>(context).genre);
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: event.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: event.isNotEmpty ? event.length : 6,
        itemBuilder: event.isNotEmpty
            ? (ctx, i) => EventHomeItem(event[i])
            : (ctx, i) => const ShimmerItem(150, 220),
      ),
    );
  }
}

List<Event> _performSearch(List<Event> event, String _query) {
  List<Event> _filterList = [];
  for (int i = 0; i < event.length; i++) {
    final item = event[i];
    if (item.namagenre.toLowerCase().contains(_query.toLowerCase()) &&
        item.visibleevent.toLowerCase().contains('public')) {
      _filterList.add(item);
    }
  }
  return _filterList;
}

List<Event> searchpublic(List<Event> event) {
  List<Event> _filterList = [];
  for (int i = 0; i < event.length; i++) {
    final item = event[i];
    if (item.visibleevent.toLowerCase().contains('public')) {
      _filterList.add(item);
    }
  }
  return _filterList;
}
