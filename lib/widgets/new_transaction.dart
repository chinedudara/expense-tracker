import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();
  final priceInput = TextEditingController();
  DateTime _selectedDate;

  _submitTx() {
    if (titleInput.text.isEmpty ||
        double.parse(priceInput.text) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget._addNewTransaction(
        titleInput.text, double.parse(priceInput.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) => setState(() {
              if (pickedDate == null) {
                return;
              }
              _selectedDate = pickedDate;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleInput,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitTx(),
              ),
              TextField(
                controller: priceInput,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTx(),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date selected'
                          : 'Transaction Date: ${DateFormat().add_yMMMMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                        onPressed: _showDate,
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            // fontSize: 17,
                          ),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitTx,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
