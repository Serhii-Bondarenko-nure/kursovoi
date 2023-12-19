import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderInitial()) {
    on<RepeatDaySelectedEvent>((event, emit) {
      selectedRepeatDayIndex = event.index;
      dayTime = event.dayTime;
      emit(RepeatDaySelectedState(index: selectedRepeatDayIndex));
    });
    on<ReminderNotificationTimeEvent>((event, emit) {
      emit(ReminderNotificationState());
    });
    on<OnSaveTappedEvent>((event, emit) {
      //_scheuleAtParticularTimeAndDate(reminderTime, dayTime);
      emit(OnSaveTappedState());
    });
  }

  int? selectedRepeatDayIndex;
  late DateTime reminderTime;
  int? dayTime;

  Future _scheuleAtParticularTimeAndDate(
      DateTime dateTime, int? dayTime) async {
    final flutterNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      //'your other channel description'
    );
    //final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: null, //iOSPlatformChannelSpecifics,
    );

    await flutterNotificationsPlugin.zonedSchedule(
      1,
      "Fitness",
      "Hey, it's time to start your exercises!",
      _scheduleWeekly(dateTime, days: _createNotificationDayOfTheWeek(dayTime)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  TZDateTime _scheduleDaily(DateTime dateTime) {
    final now = TZDateTime.now(local);
    var timezoneOffset = DateTime.now().timeZoneOffset;
    final scheduleDate = TZDateTime.utc(now.year, now.month, now.day)
        .add(Duration(hours: dateTime.hour, minutes: dateTime.minute))
        .subtract(Duration(hours: timezoneOffset.inHours));

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  TZDateTime _scheduleWeekly(DateTime dateTime, {required List<int>? days}) {
    TZDateTime scheduleDate = _scheduleDaily(dateTime);

    for (final int day in days ?? []) {
      scheduleDate = scheduleDate.add(Duration(days: day));
    }

    return scheduleDate;
  }

  // DateTime _scheduleDaily(DateTime dateTime) {
  //   final now = DateTime.now();
  //   var timezoneOffset = DateTime.now().timeZoneOffset;
  //   final scheduleDate = DateTime.utc(now.year, now.month, now.day)
  //       .add(Duration(hours: dateTime.hour, minutes: dateTime.minute))
  //       .subtract(Duration(hours: timezoneOffset.inHours));

  //   return scheduleDate.isBefore(now)
  //       ? scheduleDate.add(const Duration(days: 1))
  //       : scheduleDate;
  // }

  // DateTime _scheduleWeekly(DateTime dateTime, {required List<int>? days}) {
  //   DateTime scheduleDate = _scheduleDaily(dateTime);

  //   for (final int day in days ?? []) {
  //     scheduleDate = scheduleDate.add(Duration(days: day));
  //   }

  //   return scheduleDate;
  // }

  List<int> _createNotificationDayOfTheWeek(int? dayTime) {
    switch (dayTime) {
      case 0:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.saturday,
          DateTime.sunday
        ];
      case 1:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday
        ];
      case 2:
        return [DateTime.saturday, DateTime.sunday];
      case 3:
        return [DateTime.monday];
      case 4:
        return [DateTime.tuesday];
      case 5:
        return [DateTime.wednesday];
      case 6:
        return [DateTime.thursday];
      case 7:
        return [DateTime.friday];
      case 8:
        return [DateTime.saturday];
      case 9:
        return [DateTime.sunday];
      default:
        return [];
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
