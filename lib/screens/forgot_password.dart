import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/form_validators.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/buttons/small_button.dart';
import 'package:passkey/shared/widgets/forms/custom_form_button.dart';
import 'package:passkey/shared/widgets/forms/custom_text_field.dart';
import 'package:passkey/shared/widgets/screens/pop_up.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    emailController.removeListener(_validateEmail);
    emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      isEmailValid = emailController.text.isValidEmail;
    });
  }

  void sendRecoveryEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: emailController.text.trim());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 190,
          title: SvgPicture.asset(AppIcons.signInIcon,
              theme: const SvgTheme(currentColor: Colors.white),
              semanticsLabel: 'Sign In',
              width: 120,
              height: 120),
          elevation: 0.0,
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: primaryColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(74),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          t.forgot_password_title,
                          style: titleStyle,
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            t.forgot_password_hint_text,
                            textAlign: TextAlign.center,
                            style: messageStyle,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                            controller: emailController,
                            name: t.shared_user_email,
                            validator: Validators.emailValidator),
                        const SizedBox(height: 30),
                        CustomFormButton(
                          text: t.forgot_password_button_text,
                          onPressed: () {
                            isEmailValid ? sendRecoveryEmail : () => {};
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => PopUp(
                                insidePx: 36,
                                closeBtn: false,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: t.forgot_password_pop_up_btn,
                                    ),
                                    const SizedBox(height: 20),
                                    SmallButton(
                                      onTap: () =>
                                          Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.signIn,
                                        (route) => false,
                                      ),
                                      btnText: t.shared_btn_ok,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          disabled: !isEmailValid,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
