import 'package:cherryticketmobile/providerAPI/genre_api.dart';
import 'package:cherryticketmobile/view/list/item/genre_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreView extends StatefulWidget {
  const GenreView({Key key}) : super(key: key);

  @override
  _GenreViewState createState() => _GenreViewState();
}

class _GenreViewState extends State<GenreView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GenreList();
  }
}

class GenreList extends StatelessWidget {
  const GenreList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genredata = Provider.of<GenreAPI>(context);
    final genre = genredata.items;
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: genre.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: genre.isNotEmpty ? genre.length : 6,
        itemBuilder: genre.isNotEmpty
            ? (ctx, i) => GenreItem(genre[i], i)
            : (ctx, i) => const ShimmerItem(90, 70),
      ),
    );
  }
}
