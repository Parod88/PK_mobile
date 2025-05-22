import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:passkey/domain/models/payments/payment.dart';
import 'package:passkey/domain/models/payments/card_detail.dart';
import 'package:passkey/domain/models/user/user.dart';
import 'package:passkey/shared/utils/money.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeService {
  static Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
        options: const PaymentSheetPresentOptions(timeout: 300000),
      );
      return true;
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
    return false;
  }

  static createPaymentIntent({
    required String email,
    required Payment payment,
  }) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(payment.amount),
        'currency': payment.currency,
        'bookingId': payment.bookingId,
        'email': email,
      };
      final response = await http.post(
        Uri.parse(dotenv.env['PAYMENT_INTENT_URL']!),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  static Future<bool> makePayment({
    required UserModel user,
    required Payment payment,
  }) async {
    try {
      final paymentIntent =
          await createPaymentIntent(email: user.email, payment: payment);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: paymentIntent!['customer'],
          paymentIntentClientSecret: paymentIntent!['paymentIntent'],
          customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
          style: ThemeMode.light,
          billingDetails: BillingDetails(
              address: Address(
            country: 'ES',
            city: user.city,
            line1: user.address,
            line2: '',
            state: '',
            postalCode: '',
          )),
          merchantDisplayName: 'PassKey',
        ),
      );

      return displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  static calculateAmount(double amount) {
    final calculatedAmount = int.parse((amount * 100).ui);
    return calculatedAmount.toString();
  }

  static Future<List<CardDetail>> getCardDetails(String customerId) async {
    final response = await http.get(
      Uri.parse(
          'https://api.stripe.com/v1/customers/$customerId/payment_methods'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Basic ${base64Encode(utf8.encode(dotenv.env['STRIPE_SECRET']!))}'
      },
    );
    final List<dynamic> data = json.decode(response.body)['data'];
    return data.map((paymentMethod) {
      final card = paymentMethod['card'];
      return CardDetail(
        lastDigits: card['last4'],
        expMonth: card['exp_month'],
        expYear: card['exp_year'],
        brand: card['brand'],
      );
    }).toList();
  }
}
