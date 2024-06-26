import 'package:authorization/core/constants/color_constants.dart';
import 'package:authorization/core/constants/text_constants.dart';
import 'package:authorization/core/services/validation_service.dart';
import 'package:authorization/features/authorization/change_password/bloc/change_password_bloc.dart';
import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/common_widgets/fitness_loading.dart';
import 'package:authorization/features/common_widgets/settings_container.dart';
import 'package:authorization/features/common_widgets/settings_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  bool isNewPassInvalid = false;
  bool isConfirmPassInvalid = false;
  late String userName;

  @override
  void initState() {
    userName = user?.displayName ?? "No Username";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildContext(context),
        appBar: AppBar(
            title: const Text(TextConstants.changePassword,
                style: TextStyle(color: Colors.black, fontSize: 18)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: const IconThemeData(
              color: ColorConstants.primaryColor,
            )));
  }

  BlocProvider<ChangePasswordBloc> _buildContext(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (context) => ChangePasswordBloc(),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        buildWhen: (_, currState) =>
            currState is ChangePasswordInitial ||
            currState is ChangePasswordError ||
            currState is ChangePasswordProgress ||
            currState is ChangePasswordSuccess,
        builder: (context, state) {
          if (state is ChangePasswordProgress) {
            return Stack(children: [
              _editAccountContent(context),
              const FitnessLoading()
            ]);
          }
          if (state is ChangePasswordError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            });
          }
          if (state is ChangePasswordSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            });
          }
          return _editAccountContent(context);
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

  Widget _editAccountContent(BuildContext context) {
    ChangePasswordBloc _bloc = BlocProvider.of<ChangePasswordBloc>(context);
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SizedBox(
          height: height - 140 - MediaQuery.of(context).padding.bottom,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 15),
            const Text(TextConstants.newPassword,
                style: TextStyle(fontWeight: FontWeight.w600)),
            SettingsContainer(
              child: SettingsTextField(
                controller: _newPassController,
                obscureText: true,
                placeHolder: TextConstants.passwordPlaceholder,
              ),
            ),
            if (isNewPassInvalid)
              const Text(TextConstants.passwordErrorText,
                  style: TextStyle(color: ColorConstants.errorColor)),
            const SizedBox(height: 10),
            const Text(TextConstants.confirmPassword,
                style: TextStyle(fontWeight: FontWeight.w600)),
            SettingsContainer(
              child: SettingsTextField(
                controller: _confirmPassController,
                obscureText: true,
                placeHolder: TextConstants.confirmPasswordPlaceholder,
              ),
            ),
            if (isConfirmPassInvalid)
              const Text(TextConstants.confirmPasswordErrorText,
                  style: TextStyle(color: ColorConstants.errorColor)),
            const Spacer(),
            FitnessButton(
              title: TextConstants.save,
              isEnabled: true,
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  isNewPassInvalid =
                      !ValidationService.password(_newPassController.text);
                  isConfirmPassInvalid =
                      _newPassController.text != _confirmPassController.text;
                });
                if (!(isNewPassInvalid || isConfirmPassInvalid)) {
                  _bloc.add(ChangePassword(newPass: _newPassController.text));
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
