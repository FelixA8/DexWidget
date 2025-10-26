class WalletNetWorth {
  final String totalNetworthUsd;
  final List<ChainData> chains;

  const WalletNetWorth({
    required this.totalNetworthUsd,
    required this.chains,
  });

  factory WalletNetWorth.fromJson(Map<String, dynamic> json) {
    return WalletNetWorth(
      totalNetworthUsd: json['total_networth_usd'] as String,
      chains: (json['chains'] as List)
          .map((chain) => ChainData.fromJson(chain as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_networth_usd': totalNetworthUsd,
      'chains': chains.map((chain) => chain.toJson()).toList(),
    };
  }
}

class ChainData {
  final String chain;
  final String nativeBalance;
  final String nativeBalanceFormatted;
  final String nativeBalanceUsd;
  final String tokenBalanceUsd;
  final String networthUsd;

  const ChainData({
    required this.chain,
    required this.nativeBalance,
    required this.nativeBalanceFormatted,
    required this.nativeBalanceUsd,
    required this.tokenBalanceUsd,
    required this.networthUsd,
  });

  factory ChainData.fromJson(Map<String, dynamic> json) {
    return ChainData(
      chain: json['chain'] as String,
      nativeBalance: json['native_balance'] as String,
      nativeBalanceFormatted: json['native_balance_formatted'] as String,
      nativeBalanceUsd: json['native_balance_usd'] as String,
      tokenBalanceUsd: json['token_balance_usd'] as String,
      networthUsd: json['networth_usd'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chain': chain,
      'native_balance': nativeBalance,
      'native_balance_formatted': nativeBalanceFormatted,
      'native_balance_usd': nativeBalanceUsd,
      'token_balance_usd': tokenBalanceUsd,
      'networth_usd': networthUsd,
    };
  }
}