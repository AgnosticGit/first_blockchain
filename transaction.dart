class Transaction {
  const Transaction({
    required this.amount,
    required this.fromAddress,
    required this.toAddress,
  });

  final String fromAddress;
  final String toAddress;
  final double amount;

  void calculateHash() {}

  @override
  String toString() {
    return '''\n\n fromAddress: $fromAddress\n toAddress: $toAddress\n amount: $amount''';
  }
}
