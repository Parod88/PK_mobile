import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/screens/auth/bloc/auth_cubit.dart';
import 'package:passkey/screens/auth/widgets/socials_btn.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/shared/utils/form_validators.dart';
import 'package:passkey/shared/widgets/forms/custom_form_button.dart';
import 'package:passkey/shared/widgets/forms/custom_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final bool hasError = false;
  late AuthCubit _authCubit;
  bool isInvalid = true;

  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void signIn(String email, String password) async {
    _authCubit.signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Form(
      onChanged: () => setState(() {
        isInvalid = Validators.emailValidator(_emailController.text) != null ||
            Validators.passwordValidator(_passController.text) != null;
      }),
      child: Column(
        children: [
          Text(
            t.sign_in_title,
            style: titleStyle,
          ),
          const SizedBox(height: 30),
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
          _forgotPassword(t),
          CustomFormButton(
            text: t.sign_in_button_text,
            disabled: isInvalid,
            onPressed: () => signIn(
              _emailController.text,
              _passController.text,
            ),
          ),
          const SocialsBtn(
            socialsBtnType: SocialsBtnType.signIn,
          ),
          _goToSignUp(t),
        ],
      ),
    );
  }

  Widget _forgotPassword(AppLocalizations t) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.forgotPassword),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Text(
          t.sign_in_forgot_password,
          style: const TextStyle(
              color: softTextColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _goToSignUp(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.only(top: 86.0, bottom: 50.0),
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
                  text: t.sign_in_not_registered_normal,
                  style: const TextStyle(
                      color: softTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: t.sign_in_not_registered_link,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(
                          context,
                          Routes.signUp,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
