import 'package:flutter/material.dart';
import 'package:passkey/screens/profile/widgets/profile_input.dart';
import 'package:passkey/shared/routes/widgets/section_title.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/widgets/buttons/main_button.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({super.key});

  @override
  AddCreditCardState createState() => AddCreditCardState();
}

class AddCreditCardState extends State<AddCreditCard> {
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    ownerController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations t = AppLocalizations.of(context)!;

    return ScreenLayout(
        pt: 65,
        pl: 19,
        pr: 19,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SectionTitle(
                        title: t.profile_pay_data_title,
                        icon: AppIcons.leftArrowIcon),
                    const SizedBox(height: 19),
                    ProfileInput(
                      title: t.profile_pay_data_owner,
                      controller: ownerController,
                    ),
                    ProfileInput(
                      title: t.profile_pay_data_card_number,
                      controller: cardController,
                      hintText: '0000 0000 0000 0000',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.38),
                          child: ProfileInput(
                            title: t.profile_pay_data_expiry_date,
                            controller: expiryController,
                            hintText: 'MM/YY',
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.38),
                          child: ProfileInput(
                            title: t.profile_pay_data_cvv,
                            controller: cvvController,
                            isObscure: true,
                            hintText: '000',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 77),
              child: MainButton(btnText: t.shared_btn_save_changes),
            ),
          ],
        ));
  }
}
