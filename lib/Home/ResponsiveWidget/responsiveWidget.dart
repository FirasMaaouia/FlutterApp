import 'package:esprit/SizeConfig.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget potrait;
  final Widget landscape;

  const ResponsiveWidget({Key key, this.potrait, this.landscape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SizeConfig1.isMobilePortrait && SizeConfig1.isPortrait) {
      return potrait;
    }
    return landscape;
  }
}
