class ERC20Token {
  final String name;
  final String symbol;
  final String? logo;
  final String balance;

  ERC20Token({
    required this.name,
    required this.symbol,
    required this.balance,
    this.logo,
  });

  factory ERC20Token.fromJson(Map<String, dynamic> json) {
    return ERC20Token(
      name: json['name'],
      symbol: json['symbol'],
      balance: json['balance'],
      logo: json['logo'],
    );
  }
}