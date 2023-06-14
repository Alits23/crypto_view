class Crypto {
  String? id;
  int? rank;
  String? symbol;
  String? name;
  double? marketCapUsd;
  double? priceUsd;
  double? changePercent24hr;
  Crypto(
    this.id,
    this.rank,
    this.symbol,
    this.name,
    this.marketCapUsd,
    this.priceUsd,
    this.changePercent24hr,
  );

  factory Crypto.fromMapJson(Map<String, dynamic> fromJson) {
    return Crypto(
      fromJson['id'],
      int.parse(fromJson['rank']),
      fromJson['symbol'],
      fromJson['name'],
      double.parse(fromJson['marketCapUsd']),
      double.parse(fromJson['priceUsd']),
      double.parse(fromJson['changePercent24Hr']),
    );
  }
}
