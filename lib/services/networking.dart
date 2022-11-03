import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'Your Coin Api Key';

class RateHelper {
  final Map<String, dynamic> defaultParams = {
    'appid': apiKey,
  };
  final String fromUnit;
  final String toUnit;
  RateHelper({this.fromUnit, this.toUnit});

  Future<dynamic> getRateData() async {
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "X-CoinAPI-Key": apiKey
    };

    http.Response response = await http.get(
      Uri.https('rest.coinapi.io', 'v1/exchangerate/$fromUnit/$toUnit'),
      headers: userHeader,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
