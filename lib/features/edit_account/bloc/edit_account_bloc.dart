import 'dart:async';

import 'package:authorization/core/services/firebase_storage_service.dart';
import 'package:authorization/core/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountInitial()) {
    on<EditAccountEvent>((event, emit) async {
      try {
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          emit(EditAccountProgress());
          await FirebaseStorageService.uploadImage(filePath: image.path);
          emit(EditPhotoSuccess(image));
        }
      } catch (e, st) {
        emit(EditAccountError(e.toString(), exeption: e));
        await Future.delayed(const Duration(seconds: 1));
        emit(EditAccountInitial());

        GetIt.I<Talker>().handle(e, st);
      }
    });
    on<ChangeUserData>((event, emit) async {
      try {
        await UserService.changeUserData(
            displayName: event.displayName, email: event.email);
        emit(EditAccountInitial());
      } catch (e, st) {
        emit(EditAccountError(e.toString(), exeption: e));
        await Future.delayed(const Duration(seconds: 1));
        emit(EditAccountInitial());

        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
