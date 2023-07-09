import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_mode.dart';

class HiveDataBase {
//reference
  final _myBox = Hive.box("expense_database");

//save data

  void saveData(List<ExpenseItem> ExpenseData) {
    List<List<dynamic>> expenseList = [];
    
    for (var expense in ExpenseData) {
      List<dynamic> expenseListItem = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      expenseList.add(expenseListItem);
    }
    _myBox.put("ALL_EXPENSES", expenseList);
  }

//read data
  List<ExpenseItem> readData() {
    List expenselist = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> expenseListItem = [];
    for (int i = 0; i < expenselist.length; i++) {
//collect individual expense data
      String name;
      String amount;
      DateTime dateTime;

      name = expenselist[i][0];
      amount = expenselist[i][1];
      dateTime = expenselist[i][2];
//add expense to list of expenseList
      ExpenseItem expenseItem =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);
      expenseListItem.add(expenseItem);
    }
    return expenseListItem;
  }
}
