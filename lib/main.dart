import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:currency_converter/CurrencyFrom.dart';
import 'package:shared_preferences/shared_preferences.dart';


String frmBtn = 'From';
String toBtn = 'To';

void main() => runApp(MaterialApp(
  home: Home(),
  debugShowCheckedModeBanner: false,
));

class Home extends StatefulWidget {
 final currencyFromView;
  const Home(
    {Key key, this.currencyFromView}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    List<String> currencies = <String>['AUD','USD','INR','EUR','JPY','GBP'];
    //    List<String> currencies = <String>['AUD','USD','INR','EUR','JPY','GBP','CAD','HKD','NZD','SGD','RUB','ZAR','IDR','MYR'];

    String defaultValue = 'AUD';
    String secondValue = 'INR';
    String currencyFrom = 'AUD';
    String currencyTo = 'INR';
    String rate = '0.0';

    Future <String> fetchData() async{

    final response = await http.get(
        Uri.encodeFull('https://currency-exchange.p.rapidapi.com/exchange?q=1.0&from=$frmBtn&to=$toBtn'),
        headers: {"x-rapidapi-host": "currency-exchange.p.rapidapi.com",
                  "x-rapidapi-key": "a5iA8cQkhomshtCrWz32wErhlsWgp1oXi4YjsnqOR1SzGmhfzq"}
    );
    
    if(response.statusCode == 200){
     // currencyRate = json.decode(response.body);      
      setState(() {
            rate = json.decode(response.body).toString();
      });
      return 'true';
    }
    else{
      throw Exception('Failed to fetch data');
    }
  }
  
  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Select a currency from which you want to convert:',
                  style: TextStyle(color: Colors.blueGrey,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 25.0),),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
              color: Colors.blueAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
              onPressed: (){
                  _selectCurrencyFrom(context);
              },
              
              child: Text('$frmBtn',
                        style: TextStyle(color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 25.0)),
            ),
            )
          ),

          Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Select a currency to which you want to convert:',
                style: TextStyle(color: Colors.blueGrey,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 25.0)),
        ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
              color: Colors.blueAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
              onPressed: (){
                  _selectCurrencyTo(context);
              },
              
              child: Text('$toBtn',
                        style: TextStyle(color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 25.0)),
            ),
            )
          ),


        


          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                onPressed: (){
                    fetchData();
                },
                child: Text('Convert',
                      style: TextStyle(color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 30.0)),
              ),
            ),
          ),
          Text('$rate',
               style: TextStyle(color: Colors.blueGrey,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 30.0)),
        ],
      ),
    );
  }
}

_selectCurrencyFrom(BuildContext context) async{
    final selectedCurrency = await Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CurrencyFrom()));
    print('$selectedCurrency');

    final cFrom = await SharedPreferences.getInstance();
    cFrom.setString('CurrencyFrom', '$selectedCurrency'); 

    if(selectedCurrency == null){
        frmBtn = 'From';
    }
    else{
        frmBtn = selectedCurrency;
    }
    
  
}

_selectCurrencyTo(BuildContext context) async{
    final selectedCurrency = await Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CurrencyFrom()));
    print('$selectedCurrency');

    final cFrom = await SharedPreferences.getInstance();
    cFrom.setString('CurrencyTo', '$selectedCurrency');   

    if(selectedCurrency == null){
        toBtn = 'To';
    }
    else{
        toBtn = selectedCurrency;
    }
}



