class TokenResponse {
  final String? cursor;
  final int page;
  final int pageSize;
  final int blockNumber;
  final List<ERC20Token> result;

  TokenResponse({
    required this.cursor,
    required this.page,
    required this.pageSize,
    required this.blockNumber,
    required this.result,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      cursor: json['cursor'] ?? '',
      page: json['page'] ?? 0,
      pageSize: json['page_size'] ?? 0,
      blockNumber: json['block_number'] ?? 0,
      result: (json['result'] as List<dynamic>)
          .map((item) => ERC20Token.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cursor': cursor,
      'page': page,
      'page_size': pageSize,
      'block_number': blockNumber,
      'result': result
    };
  }
}

class ERC20Token {
  final String tokenAddress;
  final String name;
  final String symbol;
  final String? logo;
  final String? thumbnail;
  final int decimals;
  final String balance;
  final bool possibleSpam;
  final bool verifiedContract;
  final String? totalSupply;
  final String? totalSupplyFormatted;
  final double? percentageRelativeToTotalSupply;
  final int? securityScore;
  final String balanceFormatted;
  final double usdPrice;
  final double usdPrice24HChange;
  final double usdValue;
  final double usdValue24HChange;
  final bool nativeToken;
  final double portfolioPercentage;

  ERC20Token({
    required this.tokenAddress,
    required this.name,
    required this.symbol,
    required this.balance,
    required this.decimals,
    required this.possibleSpam,
    required this.verifiedContract,
    this.totalSupply,
    this.totalSupplyFormatted,
    this.percentageRelativeToTotalSupply,
    this.securityScore,
    required this.balanceFormatted,
    required this.usdPrice,
    required this.usdPrice24HChange,
    required this.usdValue,
    required this.usdValue24HChange,
    required this.nativeToken,
    required this.portfolioPercentage,
    this.logo,
    this.thumbnail,
  });

  factory ERC20Token.fromJson(Map<String, dynamic> json) {
    return ERC20Token(
      tokenAddress: json['token_address'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      logo: json['logo'],
      thumbnail: json['thumbnail'],
      decimals: json['decimals'] ?? 0,
      balance: json['balance'] ?? '0',
      possibleSpam: json['possible_spam'] ?? false,
      verifiedContract: json['verified_contract'] ?? false,
      totalSupply: json['total_supply'],
      totalSupplyFormatted: json['total_supply_formatted'],
      percentageRelativeToTotalSupply: (json['percentage_relative_to_total_supply'] as num?)?.toDouble(),
      securityScore: json['security_score'],
      balanceFormatted: json['balance_formatted'] ?? 0.0,
      usdPrice: (json['usd_price'] as num?)?.toDouble() ?? 0.0,
      usdPrice24HChange: (json['usd_price_24hr_percent_change'] as num?)?.toDouble() ?? 0.0,
      usdValue: (json['usd_value'] as num?)?.toDouble() ?? 0.0,
      usdValue24HChange: (json['usd_value_24hr_usd_change'] as num?)?.toDouble() ?? 0.0,
      nativeToken: json['native_token'] ?? false,
      portfolioPercentage: (json['portfolio_percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_address': tokenAddress,
      'name': name,
      'symbol': symbol,
      'logo': logo,
      'thumbnail': thumbnail,
      'decimals': decimals,
      'balance': balance,
      'possible_spam': possibleSpam,
      'verified_contract': verifiedContract,
      'total_supply': totalSupply,
      'total_supply_formatted': totalSupplyFormatted,
      'percentage_relative_to_total_supply': percentageRelativeToTotalSupply,
      'security_score': securityScore,
      'balance_formatted': balanceFormatted,
      'usd_price': usdPrice,
      'usd_price_24hr_percent_change': usdPrice24HChange,
      'usd_value': usdValue,
      'usd_value_24hr_usd_change': usdValue24HChange,
      'native_token': nativeToken,
      'portfolio_percentage': portfolioPercentage,
    };
  }
}
