import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/screens/auth/bloc/auth_cubit.dart';
import 'package:passkey/screens/auth/bloc/auth_state.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/mixin/floating_toast.dart';
import 'package:passkey/shared/routes/routes.dart';
import 'package:passkey/shared/mixin/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthGuard extends StatefulWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard>
    with LoadingOverlay, FloatingToast {
  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listener: (_, state) {
        if (state is AuthInitial) {
          hideSpinner();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signIn,
            (route) => false,
          );
        }
        if (state is AuthLoading) {
          showSpinner(context);
        }
        if (state is AuthSignInSuccess) {
          hideSpinner();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.onboarding,
            (route) => false,
          );
        }
        if (state is AuthUnverifiedEmail) {
          hideSpinner();
          showFloatingToast(context, t.verify_email_from_toast, "error");
        }
        if (state is AuthSignUpSuccess) {
          hideSpinner();
          if (getIt<AuthService>().user != null &&
              getIt<AuthService>().user!.emailIsVerified) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.onboarding,
              (route) => false,
            );
          } else {
            showFloatingToast(context, t.verify_email_from_toast, "info");
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signIn,
              (route) => false,
            );
          }
        }
        if (state is AuthError) {
          hideSpinner();
          showFloatingToast(context, state.message, "error");
        }
      },
      child: widget.child,
    );
  }
}
