part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {}

class RepeatDaySelectedEvent extends ReminderEvent {
  RepeatDaySelectedEvent({required this.index, required this.dayTime});

  final int index;
  final int dayTime;

  @override
  List<Object?> get props => [
        index,
        dayTime,
      ];
}

class ReminderNotificationTimeEvent extends ReminderEvent {
  ReminderNotificationTimeEvent({required this.dateTime});

  final DateTime dateTime;

  @override
  List<Object?> get props => [dateTime];
}

class OnSaveTappedEvent extends ReminderEvent {
  @override
  List<Object?> get props => [];
}
