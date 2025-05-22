import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/screens/auth/sign-up/sign_up_form.dart';
import 'package:passkey/shared/styles/styles.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.sign_up_title,
          style: signUpTitleStyle,
        ),
        elevation: 0.0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(74),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 50.0, left: 20, right: 20),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20),
                child: SignUpForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}
