import 'package:flutter/material.dart';

class CurrencyFrom extends StatefulWidget {

  @override
  _CurrencyFromState createState() => _CurrencyFromState();
}

class _CurrencyFromState extends State<CurrencyFrom> {

  List<String> currencies = <String>['AUD','USD','INR','EUR','JPY','GBP','CAD','HKD','NZD',
                                     'SGD','RUB','ZAR','IDR','MYR'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Curency From'),
        ),

        body: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, index){
            return Card(
                child: ListTile(
                  title: Text(currencies[index]),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    Navigator.pop(context,currencies[index]);
                  },
                ),
            );
          },
        ),
    );
  }
}