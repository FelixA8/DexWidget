import 'package:dexwidget/dashboard/sections/tokenInformationSection/components/percentPillView.dart';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:flutter/material.dart';

class AssetComponentView extends StatelessWidget {
  final ERC20Token token;
  const AssetComponentView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Image.network(
            token.logo ??
                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png",
            width: 32,
            height: 32,
          ),
          SizedBox(width: 12),
          Text(token.symbol, style: TextStyle(fontFamily: 'Jura', fontSize: 18)),
          Spacer(),
          Text(formatToUSD(token.usdValue), style: TextStyle(fontFamily: 'Jura', fontSize: 18)),
          SizedBox(width: 12),
          Align(
            alignment: Alignment.centerRight,
            child: PercentPill(value: token.usdPrice24HChange),
          ),
          SizedBox(width: 8),
          Image.asset("assets/icons/chevron-up.png", width: 24, height: 24,)
      
        ],
      ),
    );
  }

  String formatToUSD(double value) {
    // Round to two decimal places
    double roundedValue = double.parse(value.toStringAsFixed(2));

    // Format as USD
    return "\$ ${roundedValue.toStringAsFixed(2)}";
  }

  String formatPercentage(double value) {
    double roundedValue = double.parse(value.toStringAsFixed(2));
    return "${roundedValue} %";
  }
}
