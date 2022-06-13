import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/providerAPI/event.dart';
import 'package:cherryticketmobile/view/list/item/eventall_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventAllView extends StatefulWidget {
  const EventAllView({Key key}) : super(key: key);

  @override
  _EventAllViewState createState() => _EventAllViewState();
}

class _EventAllViewState extends State<EventAllView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const EventAllList();
  }
}

class EventAllList extends StatelessWidget {
  const EventAllList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventData = Provider.of<EventAPI>(context);
    List<Event> event = Provider.of<EventAPI>(context).genre == 'All'
        ? Provider.of<EventAPI>(context).searchvalue != ""
            ? _searchtext(
                eventData.items, Provider.of<EventAPI>(context).searchvalue)
            : searchpublic(eventData.items)
        : _performSearch(
            eventData.items,
            Provider.of<EventAPI>(context).searchvalue,
            Provider.of<EventAPI>(context).genre);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 160,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: event.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: event.isNotEmpty ? event.length : 6,
        itemBuilder: event.isNotEmpty
            ? (ctx, i) => EventAllItem(event[i])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}

List<Event> _performSearch(
  List<Event> event,
  String search,
  String _query,
) {
  List<Event> _filterList = [];
  for (int i = 0; i < event.length; i++) {
    final item = event[i];

    if (item.namagenre.toLowerCase().contains(_query.toLowerCase()) &&
        item.namaevent.toLowerCase().contains(search.toLowerCase()) &&
        item.visibleevent.toLowerCase().contains('public')) {
      _filterList.add(item);
    }
  }
  return _filterList;
}

List<Event> _searchtext(
  List<Event> event,
  String search,
) {
  List<Event> _filterList = [];
  for (int i = 0; i < event.length; i++) {
    final item = event[i];

    if (item.namaevent.toLowerCase().contains(search.toLowerCase()) &&
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
