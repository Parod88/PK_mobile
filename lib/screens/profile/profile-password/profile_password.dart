import 'package:flutter/material.dart';
import 'package:passkey/shared/routes/widgets/section_title.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/form_validators.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/buttons/main_button.dart';
import 'package:passkey/shared/widgets/forms/custom_text_field.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePassword extends StatefulWidget {
  const ProfilePassword({super.key});
  @override
  ProfilePasswordState createState() => ProfilePasswordState();
}

class ProfilePasswordState extends State<ProfilePassword> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _changePassword = false;

  @override
  void dispose() {
    confirmPassController.dispose();
    passController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    return Validators.confirmPasswordValidator(passController.text, value);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    String currentPassValue = "password";

    return ScreenLayout(
        pl: 19,
        pr: 19,
        pt: 65,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                          title: t.profile_password_title,
                          icon: AppIcons.leftArrowIcon),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          AppText(
                            text: t.profile_password_current.capitalize(),
                            size: 14,
                            letterSpacing: -0.26,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                              controller: currentPassController
                                ..text = currentPassValue,
                              showLabel: false,
                              name: "current password",
                              obscureText: true,
                              toggleObscure: false,
                              enableValidator: false,
                              validator: Validators.passwordValidator),
                          InkWell(
                            onTap: () => {
                              setState(() {
                                _changePassword = true;
                              })
                            },
                            child: AppText(
                                text: t.profile_password_change.capitalize(),
                                color: primaryColor,
                                size: 14,
                                letterSpacing: -0.26),
                          ),
                          if (_changePassword)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                AppText(
                                  text: t.profile_password_new.capitalize(),
                                ),
                                const SizedBox(height: 40),
                                CustomTextField(
                                    controller: passController,
                                    name: t.profile_password_new,
                                    obscureText: true,
                                    toggleObscure: true,
                                    validator: Validators.passwordValidator),
                                CustomTextField(
                                    controller: confirmPassController,
                                    name: t.profile_password_confirm,
                                    obscureText: true,
                                    toggleObscure: true,
                                    validator: _validateConfirmPassword),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //TODO fix the button to be fixed to the bottom
              Visibility(
                visible: _formKey.currentState?.validate() ?? false,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 79),
                  child: MainButton(btnText: t.shared_btn_save_changes),
                ),
              ),
            ],
          ),
        ));
  }
}
