import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/view/eventshowitem.dart';
import 'package:flutter/material.dart';

class EventHomeItem extends StatelessWidget {
  final Event data;

  const EventHomeItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Hero(
        tag: data.gambarevent,
        child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
            color: gray,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              image + '/GambarEvent/' + data.gambarevent,
              width: 230,
              height: 40,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventShowItem(data.idevent)),
        );
      },
    );
  }
}
