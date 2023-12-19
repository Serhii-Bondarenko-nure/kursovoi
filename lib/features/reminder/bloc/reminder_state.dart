part of 'reminder_bloc.dart';

abstract class ReminderState extends Equatable {}

class ReminderInitial extends ReminderState {
  @override
  List<Object?> get props => [];
}

class RepeatDaySelectedState extends ReminderState {
  RepeatDaySelectedState({
    required this.index,
  });

  final int? index;

  @override
  List<Object?> get props => [index];
}

class ReminderNotificationState extends ReminderState {
  @override
  List<Object?> get props => [];
}

class OnSaveTappedState extends ReminderState {
  @override
  List<Object?> get props => [];
}
