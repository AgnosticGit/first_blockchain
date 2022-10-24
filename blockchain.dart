import 'block.dart';
import 'transaction.dart';

class Blockchain {
  List<Block> blocks = [Block.genesis()];

  List<Transaction> pendingTransactions = [];

  double miningReward = 100;
  int difficulty = 2;

  void minePendingTransactions(String miningRewardAddress) {
    final newBlock = Block(
      transactions: pendingTransactions,
      timestamp: DateTime.now(),
      prevHash: blocks.last.hash,
      difficulty: difficulty,
    )..mineBlock(blocks.last);

    blocks.add(newBlock);

    pendingTransactions = [
      Transaction(
        amount: miningReward,
        fromAddress: 'Blockchain-reward',
        toAddress: miningRewardAddress,
      ),
    ];
  }

  void addTransaction(Transaction transaction) {
    pendingTransactions.add(transaction);
  }

  double getBalanceOfAddress(String address) {
    double balance = 0;

    blocks.forEach((block) {
      block.transactions.forEach((element) {
        if (element.fromAddress == address) {
          balance -= element.amount;
        }

        if (element.toAddress == address) {
          balance += element.amount;
        }
      });
    });

    return balance;
  }

  bool isValid() {
    for (int i = 1; i < blocks.length; i++) {
      final b1 = blocks[i - 1];
      final b2 = blocks[i];

      final hashIsValid = b2.hash == b2.calculateBlockHash();
      final hashesAreConvinient = b2.prevHash == b1.hash;

      if (!hashIsValid || !hashesAreConvinient) {
        return false;
      }
    }

    return true;
  }

  @override
  String toString() => blocks.toString();
}
