import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class StatisticsWeightServise {
  StatisticsWeightServise({
    required this.firebaseDatabase,
  });

  final FirebaseDatabase firebaseDatabase;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  late final userRef = firebaseDatabase.ref("users/$currentUserUid");
  late final userStatisticsRef = userRef.child("statistics");

  late final bmiRef = userStatisticsRef.child("bmi");
  late final weightRef = userStatisticsRef.child("weight");
  late final minWeightRef = userStatisticsRef.child("minWeight");
  late final maxWeightRef = userStatisticsRef.child("maxWeight");
  late final heightRef = userStatisticsRef.child("height");

  late final weightsListRef = userStatisticsRef.child("weights");

  //Получить вес, макс и мин вес, рост

  Future<double> getWeight() async {
    double weight = 0;
    try {
      final snapshot = await weightRef.get();
      if (snapshot.exists) {
        weight = double.parse(snapshot.value as String);
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return weight;
  }

  Future<double> getMinWeight() async {
    double minWeight = 0;
    try {
      final snapshot = await minWeightRef.get();
      if (snapshot.exists) {
        minWeight = double.parse(snapshot.value as String);
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return minWeight;
  }

  Future<double> getMaxWeight() async {
    double maxWeight = 0;
    try {
      final snapshot = await maxWeightRef.get();
      if (snapshot.exists) {
        maxWeight = double.parse(snapshot.value as String);
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return maxWeight;
  }

  Future<int> getHeight() async {
    int height = 0;
    try {
      final snapshot = await heightRef.get();
      if (snapshot.exists) {
        height = snapshot.value as int;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return height;
  }

  //Получение значений для графика
  Future<Map<DateTime, double>> getWeightsForGraph() async {
    Map<DateTime, double> weights = {};
    try {
      final snapshot = await weightsListRef.get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        final dats = data.entries.toList();

        for (var i = 0; i < dats.length; i++) {
          final dateString = dats[i].key;
          final toDate = dateString.split('-');
          final date = DateTime(
            int.parse(toDate[0]),
            int.parse(toDate[1]),
            int.parse(toDate[2]),
          );
          final weight = double.parse(dats[i].value as String);
          weights[date] = weight;
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    final sortWeights = Map.fromEntries(
        weights.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    return sortWeights;
  }

  //Обновить вес, макс и мин вес, рост, обновить вес по дате

  Future<bool> setWeight(double weight) async {
    try {
      await userStatisticsRef.update({
        "weight": weight.toString(),
      });

      await updateMinMaxWeight(weight);
      await setWeightByDate(weight, DateTime.now());

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //если дата сегодня - обновляет и текущий вес
  Future<bool> setWeightByDate(double weight, DateTime date) async {
    try {
      final dataYMD = "${date.year}-${date.month}-${date.day}";

      await weightsListRef.update({dataYMD: weight.toString()});

      final now = DateTime.now();

      if (now.year == date.year &&
          now.month == date.month &&
          now.day == date.day) {
        await userStatisticsRef.update({
          "weight": weight.toString(),
        });
      }

      await updateMinMaxWeight(weight);

      await setBMI();

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> updateMinMaxWeight(double weight) async {
    try {
      final minWeight = await getMinWeight();
      final maxWeight = await getMaxWeight();

      if (weight > maxWeight) {
        await setMaxWeight(weight);
      }

      if (weight < minWeight) {
        await setMinWeight(weight);
      }

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> setMinWeight(double minWeight) async {
    try {
      await userStatisticsRef.update({
        "minWeight": minWeight.toString(),
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> setMaxWeight(double maxWeight) async {
    try {
      await userStatisticsRef.update({
        "maxWeight": maxWeight.toString(),
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> setHeight(int height) async {
    try {
      await userStatisticsRef.update({
        "height": height,
      });

      await setBMI();

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //Расчитать и получить ИМТ
  //Тут в каждом обновлении веса или роста считать

  Future<double> getBMI() async {
    double bmi = 0;
    try {
      final snapshot = await bmiRef.get();
      if (snapshot.exists) {
        bmi = double.parse(snapshot.value as String);
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return bmi;
  }

  Future<bool> setBMI() async {
    try {
      final weight = await getWeight();
      final height = await getHeight();

      final double bmi = weight / ((height / 100) * (height / 100));
      await userStatisticsRef.update({
        "bmi": bmi.toStringAsFixed(1),
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }
}
