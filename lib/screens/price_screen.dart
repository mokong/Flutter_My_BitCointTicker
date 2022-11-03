import 'package:bitcoin_ticker/services/unit_rating.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectValue = 'USD';
  String btcRateValue = '';
  String ethRateValue = '';
  String ltcRateValue = '';

  @override
  void initState() {
    getRateData();
    super.initState();
  }

  void getRateData() async {
    var ratingModel = UnitRatingModle();
    var btcData = await ratingModel.getRatesData('BTC', selectValue);
    var ethData = await ratingModel.getRatesData('ETH', selectValue);
    var ltcData = await ratingModel.getRatesData('LTC', selectValue);

    print(btcData);
    print(ethData);
    print(ltcData);
    setState(() {
      if (btcData != null) {
        btcRateValue = btcData['rate'].ceil().toString();
      }
      if (ethData != null) {
        ethRateValue = ethData['rate'].ceil().toString();
      }

      if (ltcData != null) {
        ltcRateValue = ltcData['rate'].ceil().toString();
      }
    });
  }

  CupertinoPicker getPicker() {
    List<Text> children = [];
    for (var currency in currenciesList) {
      children.add(Text(currency));
    }
    return CupertinoPicker(
      children: children,
      itemExtent: 38.0,
      backgroundColor: Colors.lightBlue,
      scrollController:
          FixedExtentScrollController(initialItem: children.length - 2),
      onSelectedItemChanged: (index) {
        setState(() {
          selectValue = currenciesList[index];
          getRateData();
        });
      },
    );
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownMenus = [];
    for (var currency in currenciesList) {
      var menuItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownMenus.add(menuItem);
    }

    return DropdownButton(
      items: dropdownMenus,
      value: selectValue,
      onChanged: (value) {
        setState(() {
          selectValue = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleCardView(
                  fromValue: 'BTC',
                  rateValue: btcRateValue,
                  selectValue: selectValue),
              SingleCardView(
                  fromValue: 'ETH',
                  rateValue: ethRateValue,
                  selectValue: selectValue),
              SingleCardView(
                  fromValue: 'LTC',
                  rateValue: ltcRateValue,
                  selectValue: selectValue),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class SingleCardView extends StatelessWidget {
  const SingleCardView({
    Key key,
    @required this.fromValue,
    @required this.rateValue,
    @required this.selectValue,
  }) : super(key: key);

  final String rateValue;
  final String selectValue;
  final String fromValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $fromValue = $rateValue $selectValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
