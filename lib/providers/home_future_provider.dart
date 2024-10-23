import 'package:abhishek_fintech/models/transactions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repos/home_repo.dart';

final homeFutureProviderTransactionList = FutureProvider<List<Transactions>>((ref) async {
  return await ref.watch(homeRepoProvider).getTransactions();
});