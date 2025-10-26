import 'package:dexwidget/dashboard/sections/tokenInformationSection/components/assetComponentView.dart';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:flutter/material.dart';

class TokenInformationView extends StatelessWidget {
  final List<ERC20Token> tokens;
  const TokenInformationView({super.key, required this.tokens});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.white, // Set your desired border color here
          width: 0.5, // Optional: Set the border width
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Assets",
              style: TextStyle(fontFamily: "Jura", fontSize: 16),
            ),
          ),
          SizedBox(height: 8),
          ...tokens.asMap().entries.map((entry) {
            int index = entry.key;
            ERC20Token token = entry.value;
            return Column(
              children: [
                if (index > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                AssetComponentView(token: token),
              ],
            );
          }),
        ],
      ),
    );
  }
}
