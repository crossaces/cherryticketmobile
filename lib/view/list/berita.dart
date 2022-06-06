import 'package:carousel_slider/carousel_slider.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/providerAPI/berita.dart';
import 'package:cherryticketmobile/view/list/item/beritaitem.dart';
import 'package:cherryticketmobile/view/list/item/shimer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeritaView extends StatefulWidget {
  const BeritaView({Key key}) : super(key: key);

  @override
  _BeritaViewState createState() => _BeritaViewState();
}

class _BeritaViewState extends State<BeritaView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BeritaList();
  }
}

class BeritaList extends StatelessWidget {
  const BeritaList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beritadata = Provider.of<BeritaAPI>(context);
    final berita = beritadata.items;
    return CarouselSlider.builder(
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 2),
            enableInfiniteScroll: true,
            height: 150,
            autoPlayAnimationDuration: const Duration(milliseconds: 200),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 0.7),
        itemCount: berita.isNotEmpty ? berita.length : 5,
        itemBuilder: berita.isEmpty
            ? (context, index, realindex) => const ShimmerItem(200)
            : (context, index, realindex) => BeritaItem(berita[index]));
  }
}
