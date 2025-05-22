import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passkey/screens/profile/profile-payment-data/bloc/payment_data_state.dart';
import 'package:passkey/services/stripe_service.dart';

class PaymentDataCubit extends Cubit<PaymentDataState> {
  PaymentDataCubit() : super(PaymentDataInitial());

  void loadPaymentMethods(String stripeCustomerId) async {
    emit(PaymentDataLoading());
    final cardDetails = await StripeService.getCardDetails(stripeCustomerId);
    emit(PaymentDataSuccess(cardDetails: cardDetails));
  }
}
