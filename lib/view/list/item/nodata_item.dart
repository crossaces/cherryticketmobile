import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:flutter/material.dart';

class NoDataItem extends StatelessWidget {
  final String text;

  const NoDataItem(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 110, left: 80, bottom: 30),
          child: Image.asset("assets/images/nodata.png", fit: BoxFit.contain),
        ),
        Container(
          color: gray,
          child: AutoSizeText(text,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: cherry,
                fontWeight: FontWeight.w700,
              )),
        )
      ],
    ));
  }
}
