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

    List<String> currencies = <String>['AUD','USD','INR','EUR','JPY','GBP','CAD','HKD','NZD','SGD','RUB','ZAR','IDR','MYR'];

    String defaultValue = 'AUD';
    String secondValue = 'INR';
    String currencyFrom = 'AUD';
    String currencyTo = 'INR';
    String rate = '0.0';


    Future <String> fetchData() async{
    final response = await http.get(
        Uri.encodeFull('https://currency-exchange.p.rapidapi.com/exchange?q=1.0&from=$currencyFrom&to=$currencyTo'),
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Select a currency from which you want to convert:',
                  style: TextStyle(color: Colors.blueGrey,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 25.0),),
          ),
          DropdownButton<String>(
                      hint: Text('Select currency from'),
                      value: defaultValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueGrey),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
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

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Select a currency to which you want to convert:',
                style: TextStyle(color: Colors.blueGrey,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 25.0)),
        ),

        DropdownButton<String>(
                      hint: Text('Select currency to'),
                      value: secondValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueGrey),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                      onChanged: (String newValue){
                        setState(() {
                          secondValue = newValue;
                          currencyTo = newValue;
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
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                color: Colors.blueAccent,
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
                                   fontSize: 20.0)),
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


/*void _fetchCurrencyRate() async{
    final result = await Webservice().fetchData();
    print('$result');
}*/
