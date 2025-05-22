import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/screens/auth/bloc/auth_cubit.dart';
import 'package:passkey/screens/auth/widgets/socials_btn.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/utils/form_validators.dart';
import 'package:passkey/shared/widgets/forms/custom_form_button.dart';
import 'package:passkey/shared/widgets/forms/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _termsAndConditionSelected = false;
  bool isInvalid = true;

  late AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
  }

  void signUp() async {
    _authCubit.signUp(
      _usernameController.text,
      _emailController.text.toLowerCase(),
      _passController.text,
    );
  }

  void _checkForm() {
    setState(() {
      isInvalid = !_termsAndConditionSelected ||
          Validators.notEmptyValidator(_usernameController.text) != null ||
          Validators.passwordValidator(_passController.text) != null ||
          Validators.confirmPasswordValidator(
                _confirmPassController.text,
                _passController.text,
              ) !=
              null ||
          Validators.emailValidator(_emailController.text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return Form(
      onChanged: _checkForm,
      child: Column(
        children: [
          _inputs(t),
          CustomFormButton(
            text: t.sign_up_button_text,
            disabled: isInvalid,
            onPressed: signUp,
          ),
          const SocialsBtn(
            socialsBtnType: SocialsBtnType.signUp,
          ),
          _goToSignIn(t),
        ],
      ),
    );
  }

  _inputs(AppLocalizations t) {
    return Column(
      children: [
        CustomTextField(
          controller: _usernameController,
          name: t.sign_up_username_input_label,
          validator: Validators.notEmptyValidator,
        ),
        CustomTextField(
          controller: _emailController,
          name: t.shared_user_email,
          validator: Validators.emailValidator,
        ),
        CustomTextField(
          controller: _passController,
          name: t.sign_up_password_input_label,
          obscureText: true,
          validator: Validators.passwordValidator,
        ),
        CustomTextField(
            controller: _confirmPassController,
            name: t.sign_up_confirm_password_input_label,
            obscureText: true,
            validator: (String? text) => Validators.confirmPasswordValidator(
                  text,
                  _passController.text,
                )),
        Container(
          margin: const EdgeInsets.only(bottom: 42),
          child: Row(
            children: [
              Checkbox(
                  value: _termsAndConditionSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _termsAndConditionSelected = value ?? false;
                    });
                    _checkForm();
                  }),
              Expanded(
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: t.sign_up_terms_text_normal,
                        style: const TextStyle(
                            color: softTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: t.sign_up_terms_text_link,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _goToSignIn(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            maxLines: 2,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: t.sign_up_already_signed_up_normal,
                  style: const TextStyle(
                      color: softTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                    text: t.sign_up_already_signed_up_link,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pop(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
