import 'package:abhishek_fintech/models/transactions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class UserData {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? userName;
  @HiveField(2)
  String? userEmail;
  @HiveField(3)
  String? userPassword;
  @HiveField(4)
  List<Transactions>? userTransactions;
  @HiveField(5)
  String? userCurrency;
  @HiveField(6)
  num? monthlyLimit;
  @HiveField(7)
  num? userBalance;
  @HiveField(8)
  num? userIncome;
  @HiveField(9)
  num? userExpense;
  
  UserData({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userTransactions,
    this.userCurrency,
    this.monthlyLimit,
    this.userBalance,
    this.userIncome,
    this.userExpense,
   
  });

    factory UserData.fromJson(Map<String, dynamic> json) =>
  _$UserDataFromJson(json);
  
}
