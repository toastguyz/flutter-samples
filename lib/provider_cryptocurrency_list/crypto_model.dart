/*class Crypto {
  String name;
  String price_usd;
  String percent_change_1h;
  String symbol;

  Crypto({this.name, this.price_usd, this.percent_change_1h,this.symbol});

  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        price_usd = map['price_usd'],
        percent_change_1h = map['percent_change_1h'],
        symbol = map['symbol'];
}*/

class Cryptomodel {
  final String id;
  final String name;
  final String percentage_change;
  final String price;

  Cryptomodel({this.id, this.name, this.percentage_change, this.price});

  factory Cryptomodel.fromJson(Map<String, dynamic> json) {
    return Cryptomodel(
        id: json['id'],
        name: json['name'],
        percentage_change: json['percent_change_1h'],
        price: json['price_usd']);
  }
}
