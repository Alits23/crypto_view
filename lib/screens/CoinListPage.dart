import 'package:crypto_view/data/model/cryptoList.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoinListPage extends StatefulWidget {
  CoinListPage({super.key, this.cryptoList});
  List<Crypto>? cryptoList;
  @override
  State<CoinListPage> createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  List<Crypto>? cryptoList;

  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  Future<void> _refreshData() {
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.amber,
          backgroundColor: Colors.grey[800],
          strokeWidth: 2.0,
          displacement: 20,
          onRefresh: _refreshData,
          child: ListView.builder(
            itemCount: cryptoList!.length,
            itemBuilder: (context, index) => _getListTileItem(
              cryptoList![index],
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
}
