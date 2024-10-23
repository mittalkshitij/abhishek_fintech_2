import 'dart:developer';
import 'package:abhishek_fintech/models/transactions.dart';
import 'package:abhishek_fintech/repos/hive_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeRepo {
  final Ref ref;
  HomeRepo(this.ref);

  Future<List<Transactions>> getTransactions() async {
  try {
      final transactionList = await ref
        .read(hiveRepoProvider)
        .getAllTransactionFromHive();
       return transactionList;
  } catch (e) {
    Future.error( 'Unable to get Transactions' );
  }
  return Future.error( 'Unable to get Transactions' );

  }
}

final homeRepoProvider = Provider((ref) => HomeRepo(ref));
