import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/kota_model.dart';
import 'package:flutter/material.dart';

class KotaItem extends StatelessWidget {
  final Kota data;

  const KotaItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(children: <Widget>[
        Container(
          width: 240,
          height: 150,
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
            color: gray,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              image + '/GambarKota/' + data.gambarkota,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 240,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: AutoSizeText(
                data.namakota,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 1,
                maxFontSize: 13,
              ),
            ),
          ),
        ),
      ]),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => BeritaScreen(data.idberita)),
        // );
      },
    );
  }
}
