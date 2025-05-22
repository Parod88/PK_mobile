// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:passkey/providers/auth_provider.dart';
// import 'package:passkey/services/push_notification.dart';
// import 'package:passkey/shared/routes/routes.dart';
// import 'package:passkey/shared/styles/styles.dart';
// import 'package:passkey/shared/utils/form_validators.dart';
// import 'package:passkey/shared/widgets/forms/custom_form_button.dart';
// import 'package:passkey/shared/widgets/forms/custom_text_field.dart';
// import 'package:provider/provider.dart';

// class Recovery extends StatefulWidget {
//   const Recovery({super.key});

//   @override
//   State<Recovery> createState() => _RecoveryState();
// }

// class _RecoveryState extends State<Recovery> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passController = TextEditingController();

//   bool _isLoading = false;
//   static String? token;

//   @override
//   void initState() {
//     super.initState();
//     token = PushNotificationService.token;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passController.dispose();
//   }

//   void submitSignIn(String email, String password, context) async {
//     final loginProvider =
//         Provider.of<AuthenticationProvider>(context, listen: false);
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       final String normalizedEmail = email.trim().toLowerCase();

//       loginProvider.signIn(
//           email: normalizedEmail,
//           password: password,
//           onSuccess: () {
//             User? user = FirebaseAuth.instance.currentUser;
//             if (user != null && user.emailVerified) {
//               setState(() {
//                 _isLoading = false;
//               });

//               Navigator.pushNamedAndRemoveUntil(
//                   context, Routes.home, (route) => false);
//             } else {
//               setState(() {
//                 _isLoading = false;
//               });

//               print("User not verified");
//             }
//           },
//           onError: (error) {
//             print(error);
//           });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLocalizations t = AppLocalizations.of(context)!;

//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 190,
//           title: SvgPicture.asset('assets/sign-in.svg',
//               theme: const SvgTheme(currentColor: Colors.white),
//               semanticsLabel: 'Sign In',
//               width: 120,
//               height: 120),
//           elevation: 0.0,
//           backgroundColor: primaryColor,
//           automaticallyImplyLeading: false,
//         ),
//         backgroundColor: primaryColor,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             return Container(
//               height: constraints.maxHeight,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(74),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Text(
//                           t.sign_in_title,
//                           style: titleStyle,
//                         ),
//                         const SizedBox(height: 30),
//                         CustomTextField(
//                             controller: emailController,
//                             name: t.shared_user_email,
//                             validator: Validators.emailValidator),
//                         CustomTextField(
//                           controller: passController,
//                           name: t.sign_up_password_input_label,
//                           obscureText: true,
//                           validator: Validators.passwordValidator,
//                         ),
//                         InkWell(
//                           onTap: () => Navigator.pushNamed(
//                               context, Routes.forgotPassword),
//                           child: Padding(
//                             padding: const EdgeInsets.only(bottom: 25.0),
//                             child: Text(
//                               t.sign_in_forgot_password,
//                               style: const TextStyle(
//                                   color: softTextColor,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ),
//                         CustomFormButton(
//                             text: t.sign_in_button_text,
//                             onPressed: () => submitSignIn(emailController.text,
//                                 passController.text, context)),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 32.0),
//                           child: Row(
//                             children: <Widget>[
//                               const Expanded(child: Divider()),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 27.0),
//                                 child: Text(
//                                   t.sign_up_separator_text,
//                                   style: const TextStyle(
//                                       fontSize: 12,
//                                       color: softTextColor,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                               const Expanded(child: Divider()),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               'assets/google-logo.svg',
//                               semanticsLabel: 'Google Logo',
//                               width: 32,
//                             ),
//                             const SizedBox(width: 32),
//                             Image.asset('assets/facebook-logo.png', width: 32),
//                             const SizedBox(width: 32),
//                             SvgPicture.asset(
//                               'assets/linkedin-logo.svg',
//                               semanticsLabel: 'LinkedIn Logo',
//                               width: 32,
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(top: 86.0, bottom: 50.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               RichText(
//                                 maxLines: 2,
//                                 overflow: TextOverflow.clip,
//                                 text: TextSpan(
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: t.sign_in_not_registered_normal,
//                                       style: const TextStyle(
//                                           color: softTextColor,
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     TextSpan(
//                                         text: t.sign_in_not_registered_link,
//                                         style: const TextStyle(
//                                             color: Colors.blue,
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w600),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () =>
//                                               Navigator.popAndPushNamed(
//                                                   context, Routes.signUp)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }
