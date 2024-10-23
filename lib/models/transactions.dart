import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transactions.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Transactions {
  @HiveField(0)
  int? transactionId;
  @HiveField(1)
  String? transactionDate;
  @HiveField(2)
  num? transactionAmount;
  @HiveField(3)
  String? transactionType;
  @HiveField(4)
  String? transactionCategory;
  @HiveField(5)
  String? transactionNote;
  
  
  Transactions({
    this.transactionId,
    this.transactionDate,
    this.transactionAmount,
    this.transactionType,
    this.transactionCategory,
    this.transactionNote,
  });

    factory Transactions.fromJson(Map<String, dynamic> json) =>
  _$TransactionsFromJson(json);
  
}
