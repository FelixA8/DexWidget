import 'dart:convert';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:http/http.dart' as http;

class DexNetworkService {
  Future<List<ERC20Token>> fetchERC20Tokens(String walletAddress) async {
    final url = Uri.parse(
      'https://deep-index.moralis.io/api/v2.2/$walletAddress/erc20',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'X-API-Key':
              'YOUR_API_KEY',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data
            .map((token) => ERC20Token.fromJson(token as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Request failed (status: ${response.statusCode}) - ${response.body}',
        );
      }
    } catch (error) {
      throw Exception('Failed to fetch ERC20 tokens: $error');
    }
  }
}
