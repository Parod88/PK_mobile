import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/screens/auth/bloc/auth_cubit.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SocialsBtnType { signIn, signUp }

class SocialsBtn extends StatelessWidget {
  final SocialsBtnType socialsBtnType;
  const SocialsBtn({super.key, required this.socialsBtnType});

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Row(
            children: <Widget>[
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Text(
                  t.sign_up_separator_text,
                  style: const TextStyle(
                    fontSize: 12,
                    color: softTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => socialsBtnType == SocialsBtnType.signIn
                  ? BlocProvider.of<AuthCubit>(context).signInWithGoogle()
                  : BlocProvider.of<AuthCubit>(context).signUpWithGoogle(),
              child: SvgPicture.asset(
                AppIcons.googleIcon,
                semanticsLabel: 'Google Logo',
                width: 32,
              ),
            ),
            // const SizedBox(width: 32),
            // Image.asset(AppIcons.facebookIcon, width: 32),
            // const SizedBox(width: 32),
            // SvgPicture.asset(
            //   AppIcons.linkedinIcon,
            //   semanticsLabel: 'LinkedIn Logo',
            //   width: 32,
            // ),
          ],
        ),
      ],
    );
  }
}
