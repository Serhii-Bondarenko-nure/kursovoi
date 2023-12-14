import 'package:authorization/core/consts/hive_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'equipment.g.dart';

@HiveType(typeId: IdHiveConstants.equipmentBoxId)
class Equipment extends Equatable {
  const Equipment({required this.equipmentList});

  @HiveField(0)
  final List<String> equipmentList;

  @override
  List<Object?> get props => [equipmentList];
}
