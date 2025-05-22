class CardDetail {
  final String brand;
  final String lastDigits;
  final int expMonth;
  final int expYear;

  const CardDetail({
    required this.lastDigits,
    required this.expMonth,
    required this.expYear,
    required this.brand,
  });
}
