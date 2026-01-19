import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  double? bitcoinPrice;
  double? ethereumPrice;
  double? liteCoinPrice;
  @override
  void initState() {
    super.initState();
    loadRate();
  }

  CoinData coinData = CoinData();
  Future<void> loadRate() async {
    var currentBitcoinPrice = await coinData.getBitcoinRate(selectedCurrency);
    var currentEthereumPrice = await coinData.getETHRate(selectedCurrency);
    var currentLiteCoinPrice = await coinData.getLTCRate(selectedCurrency);
    setState(() {
      bitcoinPrice = currentBitcoinPrice;
      ethereumPrice = currentEthereumPrice;
      liteCoinPrice = currentLiteCoinPrice;
    });
  }

  String selectedCurrency = currenciesList[currenciesList.length - 2];
  DropdownButton getAndroidDropdown() {
    List<DropdownMenuItem> dropdownItems = [];
    for (String currency in currenciesList) {
      DropdownMenuItem newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        loadRate();
      },
    );
  }

  int selectedIndex = currenciesList.length - 2;
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      Text newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      children: pickerItems,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = ${bitcoinPrice == null ? '?' : bitcoinPrice.toString()} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 ETH = ${ethereumPrice == null ? '?' : ethereumPrice.toString()} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 LTC = ${liteCoinPrice == null ? '?' : liteCoinPrice.toString()} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
