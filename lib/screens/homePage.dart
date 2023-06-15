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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(cryptoList![index].name),
            subtitle: Text(cryptoList![index].symbol),
            leading: SizedBox(
              width: 30.0,
              child: Center(
                child: Text('${cryptoList![index].rank}'),
              ),
            ),
            trailing: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // price
                      Text(
                        cryptoList![index].priceUsd.toStringAsFixed(2),
                      ),
                      Text(
                        cryptoList![index].changePercent24hr.toStringAsFixed(2),
                        style: TextStyle(
                            color: getColorChangePercent24hr(
                                cryptoList![index].changePercent24hr)),
                      ),
                    ],
                  ),
                  // Icon
                  SizedBox(
                    width: 10,
                  ),
                  getIconChangePercent24hr(
                      cryptoList![index].changePercent24hr),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getIconChangePercent24hr(double changePercent24hr) {
    if (changePercent24hr == 0) {
      return Icon(
        Icons.trending_flat,
        color: Colors.grey,
      );
    } else if (changePercent24hr > 0) {
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
