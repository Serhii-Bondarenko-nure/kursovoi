import 'package:authorization/core/services/statistics_weight_service.dart';
import 'package:authorization/features/main_screens/statistics/bloc/weight_bloc/weight_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class StatisticsContent extends StatelessWidget {
  StatisticsContent({super.key});

  final weightBloc =
      WeightBloc(statisticsWeightServise: GetIt.I<StatisticsWeightServise>());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 239, 237, 239),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          const SizedBox(height: 10),
          _createWeightGraphBMI(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _createWeightGraphBMI(BuildContext context) {
    return BlocProvider<WeightBloc>(
      create: (context) => weightBloc..add(LoadWeightData()),
      child: BlocConsumer<WeightBloc, WeightState>(
        listener: (context, state) {
          if (state is NextReloadedState) {
            weightBloc.add(LoadWeightData());
          } else if (state is WeightErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.exeption.toString())));
          }
        },
        builder: (context, state) {
          if (state is WeightDataLoaded) {
            return SizedBox(
              child: Column(
                children: [
                  _createWeightGraph(
                    context,
                    state.weight,
                    state.minWeight,
                    state.maxWeight,
                    state.weightsMap,
                  ),
                  const SizedBox(height: 10),
                  _createBMI(context, state.bmi, state.height),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _createWeightGraph(
    BuildContext context,
    double weight,
    double minWeight,
    double maxWeight,
    Map<DateTime, double> weightsMap,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Weight",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    barrierColor: Colors.black.withAlpha(50),
                    backgroundColor: Colors.white,
                    builder: (context) =>
                        _createChangeWeightByDateBottomShettScreen(context));
              },
              child: const Text("Write", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 300,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 239, 237, 239),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Weight",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 90, 89, 89)),
                      ),
                      Text(
                        "$weight kg",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Heaviest weight",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 90, 89, 89)),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "$maxWeight",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Lightest weight",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 90, 89, 89)),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "$minWeight",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              _createLineChart(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _createLineChart(BuildContext context) {
    return Container();
  }

  Widget _createBMI(BuildContext context, double bmi, int height) {
    final List<Color> colorsBMI = [
      Colors.blue,
      const Color.fromARGB(255, 25, 166, 231),
      const Color.fromARGB(255, 20, 241, 204),
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];

    final List<double> widthPersentBMI = [
      9.09,
      18.18,
      36.36,
      12.12,
      12.12,
      12.12,
    ];

    final List<int> scopesBMI = [
      15,
      16,
      18,
      25,
      30,
      35,
      40,
    ];

    final List<double> paddingsBMI = [
      11,
      43,
      106,
      26,
      24,
      15,
      0,
    ];

    final List<String> lableBMI = [
      "Below normal weight",
      "Normal weight",
      "Overweight",
      "Obesity I degree",
      "Obesity II degree",
      "Obesity III degree",
    ];

    Color currentColor = colorsBMI[0];
    String currentLable = lableBMI[0];
    double scopeLangth = 0;

    for (var element in widthPersentBMI) {
      scopeLangth += element * 3.319;
    }
    double currentCursorPaddig = (bmi / 35) * scopeLangth;

    if (bmi < 15) {
      currentCursorPaddig = 0;
    } else if (bmi >= 40) {
      currentCursorPaddig = scopeLangth;
    }

    if (bmi < 18.5) {
      currentColor = colorsBMI[0];
      currentLable = lableBMI[0];
    } else if (bmi >= 18.5 && bmi < 25) {
      currentColor = colorsBMI[2];
      currentLable = lableBMI[1];
    } else if (bmi >= 25 && bmi < 30) {
      currentColor = colorsBMI[3];
      currentLable = lableBMI[2];
    } else if (bmi >= 30 && bmi < 35) {
      currentColor = colorsBMI[4];
      currentLable = lableBMI[3];
    } else if (bmi >= 35 && bmi < 40) {
      currentColor = colorsBMI[5];
      currentLable = lableBMI[4];
    } else if (bmi >= 40) {
      currentColor = colorsBMI[5];
      currentLable = lableBMI[5];
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "BMI",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    barrierColor: Colors.black.withAlpha(50),
                    backgroundColor: Colors.white,
                    builder: (context) =>
                        _createChangeWeightHeightBottomShettScreen(context));
              },
              child: const Text("Edit", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 5,
            right: 15,
          ),
          height: 150,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 239, 237, 239),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$bmi",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 20,
                            color: currentColor,
                          ),
                          Text(
                            currentLable,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
              SizedBox(
                  height: 60,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 18),
                            child: Row(
                              children: [
                                for (int i = 0; i < colorsBMI.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 1),
                                    child: Container(
                                      height: 10,
                                      width: widthPersentBMI[i] * 3.319,
                                      decoration: BoxDecoration(
                                        color: colorsBMI[i],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: 4 + currentCursorPaddig, top: 3.6),
                          //   child: const RotatedBox(
                          //     quarterTurns: 45,
                          //     child: Icon(
                          //       Icons.play_arrow,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0; i < scopesBMI.length; i++)
                              Padding(
                                padding: EdgeInsets.only(right: paddingsBMI[i]),
                                child: Text("${scopesBMI[i]}"),
                              )
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(height: 1, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Height",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      "$height cm",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Еще два метода для вызова нижних меню для изменения данных

  Widget _createChangeWeightHeightBottomShettScreen(BuildContext context) {
    final weightController = TextEditingController();
    final heightController = TextEditingController();

    weightController.text = weightBloc.weightStr;
    heightController.text = weightBloc.heightStr;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 310,
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Text(
              "Enter your weight and height!",
              style: TextStyle(fontSize: 24),
            ),
            _createTextField(context, "Weight", weightController, 5, () {}),
            _createTextField(context, "Height", heightController, 3, () {}),
            TextButton(
                onPressed: () {
                  weightBloc.add(WeightHeightChangeTapped(
                      weight: double.parse(weightController.text),
                      height: int.parse(heightController.text)));
                  AutoRouter.of(context).pop();
                },
                child: const Text(
                  "Sumbit",
                  style: TextStyle(fontSize: 27),
                )),
          ],
        ),
      ),
    );
  }

  Widget _createChangeWeightByDateBottomShettScreen(BuildContext context) {
    final weightController = TextEditingController();
    final heightController = TextEditingController();

    weightController.text = weightBloc.weightStr;
    heightController.text = weightBloc.heightStr;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 310,
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Text(
              "Enter your weight!",
              style: TextStyle(fontSize: 24),
            ),
            _createTextField(context, "Weight", weightController, 5, () {}),
            TextButton(
                onPressed: () {
                  // weightBloc.add(WeightHeightChangeTapped(
                  //     weight: double.parse(weightController.text),
                  //     height: int.parse(heightController.text)));
                  AutoRouter.of(context).pop();
                },
                child: const Text(
                  "Sumbit",
                  style: TextStyle(fontSize: 27),
                )),
          ],
        ),
      ),
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
}
