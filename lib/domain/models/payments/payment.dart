class Payment {
  double amount;
  String currency;
  String bookingId;
  String userId;
  // This ID is set automatically by a cloud function
  String? paymentId;
  // This status is updated automatically by a cloud function
  String? status;

  Payment({
    this.paymentId,
    required this.amount,
    required this.bookingId,
    required this.userId,
    this.currency = 'EUR',
    this.status,
  });

  Map<String, dynamic> toJson() => {
        'paymentId': paymentId,
        'amount': amount,
        'currency': currency,
        'userId': userId,
        'bookingId': bookingId,
        'status': status,
      };

  static Payment fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json['paymentId'],
        amount: json['amount'],
        currency: json['currency'],
        bookingId: json['bookingId'],
        status: json['status'],
        userId: json['userId'],
      );
}
