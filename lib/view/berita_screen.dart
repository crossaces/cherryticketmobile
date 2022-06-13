import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/providerAPI/berita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BeritaScreen extends StatelessWidget {
  final int idberita;
  const BeritaScreen(this.idberita, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadedBerita =
        Provider.of<BeritaAPI>(context, listen: false).findById(idberita);
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: indigo,
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: loadedBerita.gambarberita,
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            scale: 2,
                            fit: BoxFit.fill,
                            image: NetworkImage(image +
                                '/GambarBerita/' +
                                loadedBerita.gambarberita)),
                      )),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AutoSizeText(loadedBerita.judul,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: cherry)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AutoSizeText(
                      DateFormat("EEEE, dd-MMM-yyy")
                          .format(DateTime.parse(loadedBerita.tglmulai))
                          .toString(),
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 2,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black45)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Html(
                    customTextAlign: (_) => TextAlign.justify,
                    useRichText: true,
                    linkStyle: const TextStyle(
                      color: cherry,
                    ),
                    data: loadedBerita.deskripsi,
                    onLinkTap: (url) {
                      launch(url);
                    },
                    // ignore: missing_return
                    customTextStyle: (dom.Node node, TextStyle baseStyle) {
                      if (node is dom.Element) {
                        switch (node.localName) {
                          case 'h1':
                            return baseStyle.merge(const TextStyle(
                              fontSize: 20,
                              color: cherry,
                              fontWeight: FontWeight.bold,
                            ));
                          case 'p':
                            return baseStyle.merge(const TextStyle(
                              fontSize: 13,
                              color: indigo,
                              fontWeight: FontWeight.w600,
                            ));
                          case 'h2':
                            return baseStyle.merge(const TextStyle(
                              fontSize: 18,
                              color: cherry,
                              fontWeight: FontWeight.w900,
                            ));
                          case 'h3':
                            return baseStyle.merge(const TextStyle(
                              fontSize: 16,
                              color: cherry,
                              fontWeight: FontWeight.w700,
                            ));
                        }
                      }
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
