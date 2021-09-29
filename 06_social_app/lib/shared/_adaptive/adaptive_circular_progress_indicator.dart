import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveCircularProgressIndicator extends StatelessWidget {
  final String os;

  const AdaptiveCircularProgressIndicator({
    Key? key,
    required this.os,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.os == 'macos' || this.os == 'ios') {
      return CupertinoActivityIndicator();
    }

    return CircularProgressIndicator();
  }
}
