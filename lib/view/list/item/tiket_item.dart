import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';

import 'package:cherryticketmobile/model/tiket_model.dart';

import 'package:flutter/material.dart';

class TiketItem extends StatelessWidget {
  final Tiket data;

  const TiketItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: AutoSizeText(data.namatiket),
    );
  }
}
