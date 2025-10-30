import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletInformationView extends StatelessWidget {
  final String walletId;
  final String walletBalance;
  final bool isLoading;
  const WalletInformationView({
    super.key,
    required this.walletId,
    this.walletBalance = "0",
    this.isLoading = false,
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
            Text(
              _formatWalletAddress(walletId),
              style: TextStyle(fontFamily: 'Jura', fontSize: 12),
            ),
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

        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child:
              isLoading
                  ? Container(
                    key: ValueKey('loading'),
                    height: 32,
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                  : Text(
                    key: ValueKey('balance-$walletBalance'),
                    "\$ ${_formatBalance(walletBalance)}",
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ],
    );
  }

  String _formatWalletAddress(String address) {
    if (address.isEmpty) return "";
    if (address.length <= 12) return address;
    return "${address.substring(0, 6)}...${address.substring(address.length - 4)}";
  }

  String _formatBalance(String balance) {
    // Handle edge cases
    if (balance.isEmpty || balance == "0") {
      return "0.00";
    }

    try {
      final double amount = double.parse(balance);
      return amount.toStringAsFixed(2);
    } catch (e) {
      return balance; // Return original if parsing fails
    }
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
