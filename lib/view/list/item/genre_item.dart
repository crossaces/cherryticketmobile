import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/genre_model.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/providerAPI/genre_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreItem extends StatelessWidget {
  final Genre data;
  final int index;

  const GenreItem(this.data, this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beforeindex = Provider.of<GenreAPI>(context, listen: false).getIndex;
    return InkWell(
      child: Center(
        child: Container(
            margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: data.check == false ? cherry : indigo,
            ),
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.network(
                  image + '/GambarGenre/' + data.gambar,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  height: 5,
                ),
                AutoSizeText(
                  data.namagenre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    color: white,
                  ),
                  maxLines: 1,
                  minFontSize: 7,
                  maxFontSize: 10,
                ),
              ],
            )),
      ),
      onTap: () {
        Provider.of<GenreAPI>(context, listen: false)
            .touchGenre(index, beforeindex);
        Provider.of<GenreAPI>(context, listen: false).initBeforeIndex(index);
        Provider.of<EventAPI>(context, listen: false)
            .initNamaGenre(data.namagenre);
      },
    );
  }
}
