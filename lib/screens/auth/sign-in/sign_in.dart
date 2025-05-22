import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/screens/auth/sign-in/sign_in_form.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(74),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 10),
                  child: SignInForm(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
