import 'package:abhishek_fintech/ui/screens/account_setting.dart';
import 'package:abhishek_fintech/ui/screens/currency_conversion.dart';
import 'package:abhishek_fintech/ui/screens/home.dart';
import 'package:flutter/material.dart';


class BottomNavigationbarScreen extends StatefulWidget {
  const BottomNavigationbarScreen({super.key});

  @override
  State<BottomNavigationbarScreen> createState() => _BottomNavigationbarScreenState();
}

class _BottomNavigationbarScreenState extends State<BottomNavigationbarScreen> {

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), 
    const BottomNavigationBarItem(icon: Icon(Icons.currency_bitcoin_outlined), label: 'Currency Conversion'), 
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
    
    ];
  final List<Widget> screens = [const HomeScreen(), const CurrencyConversion(),const AccountSetting()];

   int navIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar : BottomNavigationBar(
        backgroundColor: Colors.transparent,
        items: items,
        currentIndex: navIndex,
         showUnselectedLabels : false, 
          selectedItemColor: Colors.white,
          unselectedItemColor : Colors.grey,
          showSelectedLabels: false,
          onTap: (int index) {
            navIndex = index;
            setState(() {
              
            });
          
          }
        ),
        body: IndexedStack(
          index: navIndex,
          children : screens,
        ),
    );
  }
}