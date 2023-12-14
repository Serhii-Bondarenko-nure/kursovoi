import 'package:authorization/core/consts/hive_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'types.g.dart';

@HiveType(typeId: IdHiveConstants.typesBoxId)
class Types extends Equatable {
  const Types({required this.typesList});

  @HiveField(0)
  final List<String> typesList;

  @override
  List<Object?> get props => [typesList];
}
