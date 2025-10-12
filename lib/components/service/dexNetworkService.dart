import 'dart:convert';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:http/http.dart' as http;

class DexNetworkService {
  Future<List<ERC20Token>> fetchERC20Tokens(String walletAddress) async {
    final url = Uri.parse(
      'https://deep-index.moralis.io/api/v2.2/$walletAddress/erc20',
    );

    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'X-API-Key':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6ImIwNDQ5ZjU3LTIxOTItNDk5MC05MjUwLTZiOWU4OTY1MjEyNCIsIm9yZ0lkIjoiNDc1NDkzIiwidXNlcklkIjoiNDg5MTY1IiwidHlwZUlkIjoiMzlkMTllZGYtMzJmYy00M2Q3LWFmOGMtMzI4ZDlmMmE2NzVkIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3NjAyNjI2NDksImV4cCI6NDkxNjAyMjY0OX0.lX7uJ3rqDv4lqWZeqPBzZdwuq-zmd6DGqoXNE7Scgic',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final tokens = data
          .map(
            (token) => ERC20Token.fromJson(
              token as Map<String, dynamic>,
            ),
          )
          .toList();

      print('Total tokens: ${tokens.length}');
      for (final token in tokens) {
        print('Symbol: ${token.symbol} | Balance: ${token.balance}');
      }

      return tokens;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [];
    }
  }
}
