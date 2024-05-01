import 'package:authorization/core/constants/hive_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'body_parts.g.dart';

@HiveType(typeId: IdHiveConstants.bodyPartsBoxId)
class BodyParts extends Equatable {
  const BodyParts({required this.bodyPartsList});

  @HiveField(0)
  final List<String> bodyPartsList;

  @override
  List<Object?> get props => [bodyPartsList];
}
