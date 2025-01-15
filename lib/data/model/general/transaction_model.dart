class Transaction {
  final String title;
  final String date;
  final String amount;
  final bool isWithdrawal;

  Transaction(
      {required this.title,
      required this.date,
      required this.amount,
      required this.isWithdrawal});
}
