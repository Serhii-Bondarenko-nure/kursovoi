import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<VerifyEmailEvent>((event, emit) {});
  }
}
