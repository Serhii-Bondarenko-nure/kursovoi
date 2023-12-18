import 'package:authorization/core/services/statistics_weight_service.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class SetInitialUserParamScreen extends StatelessWidget {
  SetInitialUserParamScreen({super.key});

  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final workoutServise = GetIt.I<StatisticsWeightServise>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 200),
          const Text(
            "Set your initial params!",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 20),
          _createTextField(context, "Weight", weightController, 5, () async {
            if (weightController.text.isNotEmpty) {
              await workoutServise
                  .setWeight(double.parse(weightController.text));
            }
          }),
          _createTextField(context, "Height", heightController, 3, () async {
            if (heightController.text.isNotEmpty) {
              await workoutServise.setHeight(int.parse(heightController.text));
            }
          }),
          const SizedBox(height: 5),
          TextButton(
              onPressed: () async {
                if (await workoutServise.getWeight() == 0 &&
                    await workoutServise.getHeight() == 0) {
                  showDialog(
                      barrierColor: Colors.black.withAlpha(50),
                      context: context,
                      builder: (context) => _createOkDialog(context));
                }
                AutoRouter.of(context).pushAndPopUntil(
                    TabBarRoute(transitionIndex: 0),
                    predicate: (route) => false);
              },
              child: const Text(
                "Sumbit",
                style: TextStyle(fontSize: 30),
              )),
        ],
      )),
    );
  }

  Widget _createTextField(
      BuildContext context,
      String title,
      TextEditingController controller,
      int length,
      void Function()? onEditingComplete) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: 70,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(length)],
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: title,
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onEditingComplete: onEditingComplete,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createOkDialog(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text("Please enter both weight and height!!!"),
      actions: [
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
      ],
    );
  }
}
