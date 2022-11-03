import 'package:bitcoin_ticker/services/networking.dart';

class UnitRatingModle {
  Future<dynamic> getRatesData(String fromUnit, String toUnit) async {
    var ratesData =
        await RateHelper(fromUnit: fromUnit, toUnit: toUnit).getRateData();
    return ratesData;
  }
}
