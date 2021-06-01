import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trawus/constants.dart';

class MainLogo extends StatelessWidget {
  const MainLogo();

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 15),
      child: Image.asset(
        mainLogo,
        fit: BoxFit.fill,
        height: 90,
        width: MediaQuery.of(context).size.width *
            (displaySize.width > 700 ? 0.2 : 0.6),
        alignment: Alignment.center,
      ),
    );
  }
}
