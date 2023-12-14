import 'package:authorization/core/consts/text_constants.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(TextConstants.statiscticIcon)),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
