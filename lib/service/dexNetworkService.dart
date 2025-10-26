import 'dart:convert';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:dexwidget/models/walletNetWorth.dart';
import 'package:http/http.dart' as http;

class DexNetworkService {
  Future<List<ERC20Token>> fetchERC20Tokens(String walletAddress) async {
    final url = Uri.parse(
      'https://deep-index.moralis.io/api/v2.2/wallets/$walletAddress/tokens?chain=eth',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'X-API-Key':
              '',
        },
      );

      switch (response.statusCode) {
        case 200:
          final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
          final data = TokenResponse.fromJson(jsonData);
          return data.result;

        case 400:
          final errorString = response.body.toString();
          final message =
              RegExp(
                r'"message":"([^"]+)"',
              ).firstMatch(errorString)?.group(1) ??
              errorString;
          throw Exception(message);

        case 401:
          throw Exception('API authentication failed. Please contact support.');

        case 403:
          throw Exception('Too many requests. Please try again later.');

        case 404:
          throw Exception(
            'Wallet address not found. Please verify the address.',
          );

        case 429:
          throw Exception(
            'Too many requests. Please wait a moment and try again.',
          );

        case 500:
        case 502:
        case 503:
          throw Exception(
            'Server is temporarily unavailable. Please try again later.',
          );

        default:
          throw Exception(
            'Request failed with status ${response.statusCode}. Please try again.',
          );
      }
    } on http.ClientException {
      throw Exception('Network connection failed. Please check your internet.');
    } on FormatException {
      throw Exception('Invalid response format from server.');
    } catch (error) {
      if (error is Exception) {
        rethrow;
      }
      throw Exception('Unknown error occurred. Please try again later.');
    }
  }

  Future<WalletNetWorth> fetchWalletBalance(String walletAddress) async {
    final url = Uri.parse(
      "https://deep-index.moralis.io/api/v2.2/wallets/$walletAddress/net-worth",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'X-API-Key':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6ImIwNDQ5ZjU3LTIxOTItNDk5MC05MjUwLTZiOWU4OTY1MjEyNCIsIm9yZ0lkIjoiNDc1NDkzIiwidXNlcklkIjoiNDg5MTY1IiwidHlwZUlkIjoiMzlkMTllZGYtMzJmYy00M2Q3LWFmOGMtMzI4ZDlmMmE2NzVkIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3NjAyNjI2NDksImV4cCI6NDkxNjAyMjY0OX0.lX7uJ3rqDv4lqWZeqPBzZdwuq-zmd6DGqoXNE7Scgic',
        },
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          return WalletNetWorth.fromJson(data);

        case 400:
          final errorString = response.body.toString();
          final message =
              RegExp(
                r'"message":"([^"]+)"',
              ).firstMatch(errorString)?.group(1) ??
              errorString;
          throw Exception(message);

        case 401:
          throw Exception('API authentication failed. Please contact support.');

        case 403:
          throw Exception('Too many requests. Please try again later.');

        case 404:
          throw Exception(
            'Wallet address not found. Please verify the address.',
          );

        case 429:
          throw Exception(
            'Too many requests. Please wait a moment and try again.',
          );

        case 500:
        case 502:
        case 503:
          throw Exception(
            'Server is temporarily unavailable. Please try again later.',
          );

        default:
          throw Exception(
            'Request failed with status ${response.statusCode}. Please try again.',
          );
      }
    } on http.ClientException {
      throw Exception('Network connection failed. Please check your internet.');
    } on FormatException {
      throw Exception('Invalid response format from server.');
    } catch (error) {
      if (error is Exception) {
        rethrow;
      }
      throw Exception('Unknown error occurred. Please try again later.');
    }
  }
}
