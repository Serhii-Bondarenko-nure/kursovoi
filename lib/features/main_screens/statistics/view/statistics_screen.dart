import 'package:authorization/core/constants/text_constants.dart';
import 'package:authorization/features/main_screens/statistics/widgets/statistics_content.dart';
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
      body: StatisticsContent(),
    );
  }
}
