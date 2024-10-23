import 'package:abhishek_fintech/models/transactions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveRepo {
  final transactionBoxName = 'transactionBox';

  void registerAdapter() {
    Hive.registerAdapter(TransactionsAdapter());
  }

  Future addTransactionToHive(Transactions transaction) async{
    final transactionBox = await Hive.openBox<Transactions>(transactionBoxName);
    if (transactionBox.isOpen) {
      await transactionBox.put(transaction.transactionId!, transaction);

    }else {
      throw Exception('Box is not open');
    }
  }

  Future deleteTransactionFromHive(String id) async {
    final transactionBox = await Hive.openBox<Transactions>(transactionBoxName);
    if (transactionBox.isOpen) {
      transactionBox.delete(id);
    } else {
      throw Exception('Box is not open');
    }
  }

  Future<List<Transactions>> getAllTransactionFromHive() async {
    final transactionBox = await Hive.openBox<Transactions>(transactionBoxName);
    if(transactionBox.isOpen) {
        return transactionBox.values.toList();
    } else {
      throw Exception('Box is not open');
    }

 }

  Future<Transactions> getSingleTransactionFromHive(String id) async {
    final transactionBox = await Hive.openBox<Transactions>(transactionBoxName);
    if(transactionBox.isOpen) {
        return transactionBox.get(id)!;
    } else {
      throw Exception('Box is not open');
    }

 }
}

final hiveRepoProvider = Provider((ref) => HiveRepo());

