import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class MapLoadingWidget extends StatelessWidget {
  const MapLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: devicedata.size.height * 0.3,
        color: Colors.grey,
      ),
    );
  }
}
