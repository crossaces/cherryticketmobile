import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/berita_model.dart';
import 'package:flutter/material.dart';

class BeritaItem extends StatelessWidget {
  final Berita beritadata;

  const BeritaItem(this.beritadata, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Hero(
          tag: beritadata.idberita,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                  scale: 2,
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      image + '/GambarBerita/' + beritadata.gambarberita)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: AutoSizeText(
                    beritadata.judul,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => BeritaScreen(beritadata.idberita)),
        // );
      },
    );
  }
}
