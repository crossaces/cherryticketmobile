import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/geteventprivate.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/view/list/eventall_list.dart';
import 'package:cherryticketmobile/view/list/genre_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventAll extends StatefulWidget {
  const EventAll({Key key}) : super(key: key);

  @override
  State<EventAll> createState() => _EventAllState();
}

class _EventAllState extends State<EventAll>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: indigo,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(56.0, 10.0, 16.0, 6.0),
                      child: Container(
                        color: indigo,
                        child: CupertinoTextField(
                          onChanged: (value) {
                            Provider.of<EventAPI>(context, listen: false)
                                .searchinit(value);
                          },
                          cursorColor: indigo,
                          keyboardType: TextInputType.text,
                          placeholder: 'Event Search',
                          placeholderStyle: const TextStyle(
                            color: Color(0xffC4C6CC),
                            fontSize: 14.0,
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                            child: Icon(
                              Icons.search,
                              color: Color(0xffC4C6CC),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const GenreView(),
                Stack(
                  children: [
                    const EventAllView(),
                    Positioned(
                        right: 10,
                        bottom: 20,
                        child: FloatingActionButton(
                            child: const Icon(Icons.vpn_key),
                            backgroundColor: indigo,
                            onPressed: () {
                              showDialog<void>(
                                  barrierColor: Colors.white.withOpacity(0.1),
                                  context: context,
                                  builder: (context) {
                                    return const GetEventWithToken();
                                  });
                            }))
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
