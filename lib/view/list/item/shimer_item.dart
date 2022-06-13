import 'package:cherryticketmobile/components/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerItem(this.height, this.width, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: Colors.grey[200],
        baseColor: Colors.grey[350],
        period: const Duration(milliseconds: 2000),
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: gray,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
              ),
            ], borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)));
  }
}
