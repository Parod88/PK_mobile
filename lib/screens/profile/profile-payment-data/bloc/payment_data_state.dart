import 'package:equatable/equatable.dart';
import 'package:passkey/domain/models/payments/card_detail.dart';

abstract class PaymentDataState extends Equatable {
  const PaymentDataState();
}

class PaymentDataInitial extends PaymentDataState {
  @override
  List<Object> get props => [];
}

class PaymentDataLoading extends PaymentDataState {
  @override
  List<Object> get props => [];
}

class PaymentDataSuccess extends PaymentDataState {
  final List<CardDetail> cardDetails;
  const PaymentDataSuccess({required this.cardDetails});

  @override
  List<Object?> get props => [];
}

class PaymentDataError extends PaymentDataState {
  final String message;
  const PaymentDataError({required this.message});

  @override
  List<Object?> get props => [message];
}
