import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions-list.dart';
import 'models/transaction.dart';

void main() {
  //BLOCK LANDSCAPE MODE
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.7,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final _userTransactions = <Transaction>[
    Transaction(
        title: 'supermarket',
        amount: 50,
        dateTime: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        title: 'headphones',
        amount: 99.99,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        title: 'shoes',
        amount: 60.5,
        dateTime: DateTime.now().subtract(Duration(days: 1))),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      dateTime: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  final appBar = AppBar(
    title: Text(
      'Personal Expenses',
      //   style: Theme.of(context)
      //       .textTheme
      //       .headline6
      //       .copyWith(color: Colors.white),
      // ),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.add),
      //     onPressed: () => _startAddNewTransaction(context),
    ),
    // ],
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Widget> _displayLandscapeContent(
      MediaQueryData mediaQuery, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.08,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                'Show Chart',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              },
            ),
          ],
        ),
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height - //height of app barr
                      mediaQuery.padding.top) * // height of status bar
                  0.8,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _displayPortraitContent(
      MediaQueryData mediaQuery, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height - //height of app barr
                mediaQuery.padding.top) * // height of status bar
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(
        context); //its better to store mediaquery in a var if you gonna use it alot
    final chartHeightRatio = 0.25;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            (0.92 - chartHeightRatio),
        child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            ..._displayLandscapeContent(mediaQuery, txListWidget),
          if (!isLandscape)
            ..._displayPortraitContent(mediaQuery, txListWidget),
        ],
      ),
    );
  }
}
