import 'package:http/http.dart' as http;
import 'package:currency_converter/CurrencyConverter.dart';
import 'dart:async';
import 'dart:convert';


class Webservice{
  Future <double> fetchData() async{
    final response = await http.get(
        Uri.encodeFull('https://currency-exchange.p.rapidapi.com/exchange?q=1.0&from=USD&to=INR'),
        headers: {"x-rapidapi-host": "currency-exchange.p.rapidapi.com",
                  "x-rapidapi-key": "a5iA8cQkhomshtCrWz32wErhlsWgp1oXi4YjsnqOR1SzGmhfzq"}
    );

    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else{
      throw Exception('Failed to fetch data');
    }

  }
}

/*
import 'package:currency_converter/CurrencyConverter.dart';
import 'package:currency_converter/Webservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';






void main() => runApp(MaterialApp(
  home: Home(),
  debugShowCheckedModeBanner: false,
));

class Home extends StatefulWidget {
  const Home(
    {Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String defaultValue = 'AUD';
  String currencyFrom;
  double currencyRate;
  String rate;
  bool _isVisible = false;

  List<String> currencies = <String>['AUD','USD','INR','EUR','JPY','GBP','CAD','HKD','NZD','SGD','RUB','ZAR','IDR','MYR'];

  Future<CurrencyConverter> apiData;

  Future <String> fetchData() async{
    final response = await http.get(
        Uri.encodeFull('https://currency-exchange.p.rapidapi.com/exchange?q=1.0&from=$currencyFrom&to=INR'),
        headers: {"x-rapidapi-host": "currency-exchange.p.rapidapi.com",
                  "x-rapidapi-key": "a5iA8cQkhomshtCrWz32wErhlsWgp1oXi4YjsnqOR1SzGmhfzq"}
    );
    
    if(response.statusCode == 200){
      currencyRate = json.decode(response.body);      
      print('Rate: $currencyRate');
      setState(() {
            rate = currencyRate.toString();
            _isVisible = true;
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
    //fetchData();   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Currency Converter'),
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.cyan[800],
              Colors.cyan[500],
              Colors.cyan[200],
            ]
          )
        ),
        child: Column(
          
          children: <Widget>[
            SizedBox(height: 80,),
            Text('Currency Converter',
                style: TextStyle(color: Colors.white,
                                 fontSize: 40,
                                 fontWeight: FontWeight.bold)
                                 ),
            SizedBox(height: 50,),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                     
                    RaisedButton(
                      onPressed: (){
                        fetchData();
                      },
                      child: Text('Fetch'),
                    ),

                    Visibility(
                      child: Text('Rate: $rate'),
                      visible: _isVisible,
                    ),
                    

                    DropdownButton<String>(
                      hint: Text('Select currency from'),
                      value: defaultValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                      onChanged: (String newValue){
                        setState(() {
                          defaultValue = newValue;
                          currencyFrom = newValue;
                        });
                      },
                      items: currencies
                      .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                        );
                      }).toList(),
                    ),  

                    SizedBox(height: 50,),
                    DropdownButton<String>(
                      hint: Text('Select currency from'),
                      value: defaultValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                      onChanged: (String newValue){
                        setState(() {
                          defaultValue = newValue;
                          currencyFrom = newValue;
                        });
                      },
                      items: currencies
                      .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                        );
                      }).toList(),
                    ),               
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

*/