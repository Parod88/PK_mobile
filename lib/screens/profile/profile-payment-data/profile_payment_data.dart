import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passkey/di/injection_container.dart';
import 'package:passkey/domain/models/payments/card_detail.dart';
import 'package:passkey/screens/profile/profile-payment-data/bloc/payment_data_cubit.dart';
import 'package:passkey/screens/profile/profile-payment-data/bloc/payment_data_state.dart';
import 'package:passkey/services/auth_service.dart';
import 'package:passkey/shared/mixin/loading.dart';
import 'package:passkey/shared/routes/widgets/section_title.dart';
import 'package:passkey/shared/styles/styles.dart';
import 'package:passkey/shared/theme/icons.dart';
import 'package:passkey/shared/utils/strings.dart';
import 'package:passkey/shared/widgets/screen_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passkey/shared/widgets/texts/app_text.dart';

class ProfilePaymentData extends StatefulWidget {
  const ProfilePaymentData({super.key});

  @override
  State<ProfilePaymentData> createState() => _ProfilePaymentDataState();
}

class _ProfilePaymentDataState extends State<ProfilePaymentData>
    with LoadingOverlay {
  late PaymentDataCubit _paymentDataCubit;
  late Future paymentDetails;

  @override
  void initState() {
    super.initState();
    final user = getIt<AuthService>().user;
    _paymentDataCubit = BlocProvider.of<PaymentDataCubit>(context);
    if (user!.stripeCustomerId != null) {
      _paymentDataCubit.loadPaymentMethods(user.stripeCustomerId!);
    }
    _paymentDataCubit.stream.listen((state) {
      if (state is PaymentDataLoading && mounted) {
        showSpinner(context);
      }
      if (state is PaymentDataSuccess) {
        hideSpinner();
      }
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                      title: t.profile_pay_data_title,
                      icon: AppIcons.leftArrowIcon),
                  const SizedBox(height: 22),
                  AppText(
                    text: t.profile_pay_data_description,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<PaymentDataCubit, PaymentDataState>(
                      builder: (_, state) {
                    if (state is! PaymentDataSuccess) return Container();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.cardDetails.length,
                      itemBuilder: (_, index) => _cardDetail(
                        t,
                        state.cardDetails[index],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardDetail(AppLocalizations t, CardDetail card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: mediumGrey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.creditCardIcon,
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text:
                          "${card.brand.capitalize()}.....${card.lastDigits}"),
                  AppText(
                    text:
                        "${t.profile_pay_data_expiry_date} ${card.expMonth}/${card.expYear}",
                    lineHeight: 1.2,
                    size: 10,
                    color: softTextColor,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
