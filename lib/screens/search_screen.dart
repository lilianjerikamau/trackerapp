import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/main.dart';

import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/create_installation_job_card.dart';
import 'package:trackerapp/screens/home.dart';
// import 'package:trackerapp/screens/Receipt.dart';
import 'package:trackerapp/utils/config.dart' as Config;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackerapp/utils/config.dart' as Config;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:query_params/query_params.dart';

class FinancierReceipt extends StatefulWidget {
  @override
  _FinancierReceiptState createState() => _FinancierReceiptState();
}

class _FinancierReceiptState extends State<FinancierReceipt> with RouteAware {
  // late User _loggedInUser;
  // User? _loggedInUser;
  List<Customer>? _customers;
  String _message = 'Loading ... ';
  late BuildContext? _context = null;
  String? _searchString;
  bool _searchmode = false;
  late final custID;
  late final custName;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _itemDescController = new TextEditingController();

  User? _loggedInUser;

  @override
  void initState() {
    SessionPreferences().getLoggedInUser().then((user) {
      setState(() {
        _loggedInUser = user;
      });
      _fetchCustomers(user.hrid!);
    });
    super.initState();
  }

  _fetchCustomers(int hrid) async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response =
        await Config.getRequestObject(url + 'customer/$hrid', Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        print(jsonResponse);
        var list = jsonResponse as List;
        List<Customer> result = list.map<Customer>((json) {
          return Customer.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          setState(() {
            result.sort((a, b) =>
                a.company!.toLowerCase().compareTo(b.company!.toLowerCase()));
            _customers = result;
          });
        } else {
          setState(() {
            _message = 'You have not been assigned any customers';
          });
        }
      });
    } else {
      print('response is null ');
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return WillPopScope(
      onWillPop: () async {
        if (_searchmode) {
          setState(() {
            _searchmode = false;
            _searchString = null;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: _searchmode
                ? TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: 'Search financier name',
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (value) {
                      setState(() {
                        _searchString = value;
                      });
                    })
                : Text(
                    'Search Financier by company name,email or phone number'),
            actions: <Widget>[
              Visibility(
                visible: !_searchmode,
                child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _searchmode = true;
                      });
                    }),
              )
            ],
          ),
          body: Container(
            color: Colors.white,
            child: _body(),
          )),
    );
  }

  _body() {
    if (_customers != null && _customers!.isNotEmpty) {
      if (_searchString != null && _searchString!.isNotEmpty) {
        List<Customer> searchResults = [];
        _customers!.forEach((customer) {
          String name = customer.company!;
          // String email = customer.custid!;
          if (name.toLowerCase().contains(_searchString!)) {
            searchResults.add(customer);
          }
        });
        return _listViewBuilder(searchResults);
      }
      return _listViewBuilder(_customers!);
    }
    return Center(
      child: Text(_message),
    );
  }

  _listViewBuilder(List<Customer> data) {
    return ListView.builder(
        itemBuilder: (bc, i) {
          Customer customer = data.elementAt(i);
          String name = customer.company!;
          // String email = financier.email!;

          print("Financier id :::: ${customer.custid}");

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name != null ? 'Name: $name' : 'Name: Undefined'),
                    // Text('Financier balance: $bal'),
                    // Text('PDCheque balance: $pdBal'),
                    // Text('Available Credit: $creditLimit')
                  ],
                ),
                onTap: () {
                  if (name != null) {
                    SessionPreferences().setSelectedCustomer(customer);
                    int? customerID = customer.custid;
                    String? custName = customer.company;

                    String itemDesc = _itemDescController.text.trim();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateJobCard(
                                custID: customerID,
                                custName: custName,
                              )),
                    );
                    // print(object)
                    Fluttertoast.showToast(msg: 'Selected Successfully!');
                    // print(customerID);
                  } else {
                    showDialog(
                        context: _context!,
                        builder: (bc) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(Icons.error, color: Colors.red),
                                Text('This financier does not exist')
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(bc);
                                  },
                                  child: Text('Ok'))
                            ],
                          );
                        });
                  }
                },
              ),
            ),
          );
        },
        itemCount: data.length);
  }
}
