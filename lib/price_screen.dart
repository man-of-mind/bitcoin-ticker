import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getPrice();
  }

  String bTCPrice;
  String lTCPrice;
  String eTHPrice;
  bool isWaiting = true;
  String selectedCurrency = 'USD';
  String btcPrice;
  String ethPrice;
  String ltcPrice;

  Future getPrice() async {
    try {
      CoinData coinData = CoinData(currency: selectedCurrency);
      List<dynamic> dataPrice = await coinData.getData();
      List<String> currentPrice = [];
      for (var jsonData in dataPrice) {
        int value = jsonData['rate'].toInt();
        currentPrice.add(value.toString());
      }
      setState(() {
        bTCPrice = currentPrice[0];
        lTCPrice = currentPrice[1];
        eTHPrice = currentPrice[2];
      });

      isWaiting = false;
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var menuItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropDownItems.add(menuItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getPrice();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String item in currenciesList) {
      var newPickerItem = Text(item);
      pickerItems.add(newPickerItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children: pickerItems,
      itemExtent: 32.0,
      onSelectedItemChanged: (int value) {
        setState(() {
          selectedCurrency = currenciesList[value];
          getPrice();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isWaiting ? btcPrice = '?' : btcPrice = bTCPrice;
    isWaiting ? ethPrice = '?' : ethPrice = eTHPrice;
    isWaiting ? ltcPrice = '?' : ltcPrice = lTCPrice;
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getContent(text: '1 BTC = $btcPrice $selectedCurrency'),
          getContent(text: '1 ETH = $ethPrice $selectedCurrency'),
          getContent(text: '1 LTC = $ltcPrice $selectedCurrency'),
          Spacer(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}

Padding getContent({@required String text}) {
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
          text,
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
