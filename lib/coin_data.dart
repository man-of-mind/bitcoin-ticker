import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String currency;
  CoinData({this.currency});
  String url = 'https://rest.coinapi.io/v1/exchangerate';
  String apiKey = '6580B483-CFA8-46F5-A88D-3DCA7529D620';
  List<dynamic> priceList = [];
  Future getData() async {
    for (String crypto in cryptoList) {
      http.Response response =
          await http.get('$url/$crypto/$currency?apikey=$apiKey');
      if (response.statusCode == 200) {
        String result = response.body;
        priceList.add(jsonDecode(result));
      }
    }
    return priceList;
  }
}
