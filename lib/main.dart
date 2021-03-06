import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'dart:math';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  void _addNewTransaction(String title, double price, DateTime date) {
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    final newTx = Transaction(
      title: title,
      price: price,
      date: date,
      id: randomNumber,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  _showAddNewTxModal(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Transaction> _transactions = [
    Transaction(
      id: 1,
      title: 'DePrince Groceries Shopping',
      price: 120.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 2,
      title: 'Akara',
      price: 200.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 3,
      title: 'Mtn Airtime',
      price: 400.00,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTxns {
    return _transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      // backgroundColor: Colors.purple,
      title: Text(
        'Expense Tracker',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddNewTxModal(context)),
      ],
    );

    final _txnList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (isLandscape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Show Chart'),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) => setState(() => _showChart = val))
              ]),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTxns),
              ),
            if (!isLandscape) _txnList,
            if (isLandscape)
              _showChart
                  ? Container(
                      width: mediaQuery.size.width * 0.7,
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTxns),
                    )
                  : _txnList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => _showAddNewTxModal(context),
              child: Icon(Icons.add),
            ),
    );
  }
}
