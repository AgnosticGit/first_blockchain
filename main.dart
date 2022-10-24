import 'blockchain.dart';
import 'transaction.dart';

void main() {
  final blockChain = Blockchain();

  blockChain.addTransaction(
    Transaction(amount: 30, fromAddress: 'slava', toAddress: 'dima'),
  );

  blockChain.minePendingTransactions('slava');

  print(blockChain);
  print(blockChain.getBalanceOfAddress('slava'));
}
