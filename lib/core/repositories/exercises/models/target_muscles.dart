import 'package:authorization/core/constants/hive_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'target_muscles.g.dart';

@HiveType(typeId: IdHiveConstants.targetMusclesBoxId)
class TargetMuscles extends Equatable {
  const TargetMuscles({required this.targetMusclesList});

  @HiveField(0)
  final List<String> targetMusclesList;

  @override
  List<Object?> get props => [targetMusclesList];
}
