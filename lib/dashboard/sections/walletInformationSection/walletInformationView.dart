import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletInformationView extends StatelessWidget {
  final String walletId;
  final String walletBalance;
  const WalletInformationView({
    super.key,
    required this.walletId,
    this.walletBalance = "0",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8,
          children: [
            Image.asset("assets/icons/wallet-icon.png"),
            Text(walletId, style: TextStyle(fontFamily: 'Jura', fontSize: 12)),
          ],
        ),
        SizedBox(height: 8),
        Text(
          "Total Worth",
          style: TextStyle(
            fontFamily: 'Jura',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        Text(
          "\$ ${walletBalance}",
          style: TextStyle(
            fontFamily: 'Jura',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String formatToUSD(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en',
      symbol: '\$',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }
}
