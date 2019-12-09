

class CurrencyConverter{
  final double currencyRate;

  CurrencyConverter({this.currencyRate});

  factory CurrencyConverter.fromJson(Map<String, dynamic> json){
    return CurrencyConverter(
      currencyRate: json['']
    );
  }
}