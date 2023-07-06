import 'package:crypto_view/data/model/cryptoList.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoinListPage extends StatefulWidget {
  CoinListPage({super.key, this.cryptoList, this.darkTheme});
  List<Crypto>? cryptoList;
  bool? darkTheme;

  @override
  State<CoinListPage> createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  List<Crypto>? cryptoList;
  bool? darkTheme;

  @override
  void initState() {
    super.initState();
    darkTheme = widget.darkTheme;
    cryptoList = widget.cryptoList;
  }

  Future<void> _refreshData() async {
    List<Crypto> fereshData = await _getData();
    setState(() {
      cryptoList = fereshData;
      darkTheme = widget.darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: darkTheme! ? Colors.white : Colors.grey[800],
          backgroundColor: darkTheme! ? Colors.blue : Colors.amber,
          strokeWidth: 3.0,
          displacement: 20,
          onRefresh: _refreshData,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              itemCount: cryptoList!.length,
              itemBuilder: (context, index) => _getListTileItem(
                cryptoList![index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getListTileItem(Crypto crypto) {
    return Column(
      children: [
        ListTile(
          title: Text(
            crypto.name,
            style: TextStyle(
              fontSize: 21,
            ),
          ),
          subtitle: Text(
            crypto.symbol,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          leading: SizedBox(
            width: 35.0,
            child: Center(
              child: Text('${crypto.rank} )'),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // price
                      Text(
                        crypto.priceUsd.toStringAsFixed(2),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        crypto.changePercent24hr.toStringAsFixed(2),
                        style: TextStyle(
                          color: getColorChangePercent24hr(
                              crypto.changePercent24hr),
                        ),
                      ),
                    ],
                  ),

                  // Icon
                  SizedBox(
                    width: 10,
                  ),
                  getIconChangePercent24hr(
                    crypto.changePercent24hr,
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Divider(
            thickness: 1,
            height: 1,
            indent: 50,
            endIndent: 50,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  Widget getIconChangePercent24hr(double changePercent24hr) {
    if (changePercent24hr > 0) {
      return Icon(
        Icons.trending_up,
        color: Colors.green,
      );
    } else {
      //changePercent24hr > 0
      return Icon(
        Icons.trending_down,
        color: Colors.redAccent,
      );
    }
  }

  Color getColorChangePercent24hr(double changePercent24hr) {
    if (changePercent24hr == 0) {
      return Colors.black;
    } else if (changePercent24hr > 0) {
      return Colors.green;
    } else {
      //changePercent24hr > 0
      return Colors.redAccent;
    }
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
