import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/screens/profile/widgets/profile_input.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/routes/widgets/section_title.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/form_validators.dart';
import 'package:passkey/shared/widgets/buttons/main_button.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';

class ProfilePersonalData extends StatefulWidget {
  const ProfilePersonalData({super.key});

  @override
  ProfilePersonalDataState createState() => ProfilePersonalDataState();
}

class ProfilePersonalDataState extends State<ProfilePersonalData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  late final String originalName;
  late final String originalSurname;
  late final String originalEmail;
  late final String originalDni;
  late final String originalAddress;
  late final String originalCity;

  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    final user = getIt<AuthService>().user!;
    nameController.text = user.username;
    surnameController.text = user.surname ?? '';
    emailController.text = user.email;
    idController.text = user.dni ?? '';
    addressController.text = user.address ?? '';
    cityController.text = user.city ?? '';

    originalName = user.username;
    originalSurname = user.surname ?? '';
    originalEmail = user.email;
    originalDni = user.dni ?? '';
    originalAddress = user.address ?? '';
    originalCity = user.city ?? '';

    nameController.addListener(_checkForChanges);
    surnameController.addListener(_checkForChanges);
    emailController.addListener(_checkForChanges);
    idController.addListener(_checkForChanges);
    addressController.addListener(_checkForChanges);
    cityController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    idController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _checkForChanges() {
    if (nameController.text != originalName ||
        surnameController.text != originalSurname ||
        emailController.text != originalEmail ||
        idController.text != originalDni ||
        addressController.text != originalAddress ||
        cityController.text != originalCity) {
      setState(() {
        hasChanges = true;
      });
    } else {
      setState(() {
        hasChanges = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context)!;
    return ScreenLayout(
        pt: 65,
        pl: 19,
        pr: 19,
        child: Column(
          children: [
            SectionTitle(
                title: t.profile_personal_data, icon: AppIcons.leftArrowIcon),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    ProfileInput(
                        controller: nameController, title: t.shared_user_name),
                    ProfileInput(
                        controller: surnameController,
                        title: t.shared_user_surname),
                    ProfileInput(
                      controller: emailController,
                      title: t.shared_user_email,
                      isEmail: true,
                      validator: Validators.emailValidator,
                    ),
                    ProfileInput(
                        controller: idController, title: t.shared_user_id),
                    ProfileInput(
                        controller: addressController,
                        title: t.shared_user_address),
                    ProfileInput(
                        controller: cityController, title: t.shared_user_city),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 79),
              child: MainButton(
                bgColor: hasChanges ? primaryColor : mediumGrey,
                btnText: t.shared_btn_save_changes,
                onTap: hasChanges ? () => _saveChanges() : null,
              ),
            ),
          ],
        ));
  }

  void _saveChanges() {
    print('Query not implemented');
  }
}
