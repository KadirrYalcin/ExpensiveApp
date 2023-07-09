import 'package:expensive_app/data/hive_database.dart';
import 'package:expensive_app/datetime/date_time_helper.dart';
import 'package:expensive_app/models/expense_mode.dart';
import 'package:flutter/cupertino.dart';

class ExpenseData extends ChangeNotifier {
  //list of expanse data
  List<ExpenseItem> overAllExpenseList = [];
  HiveDataBase db = HiveDataBase();

  //prepare database
  void prepareDB() {
    if (db.readData().isNotEmpty) {
      overAllExpenseList = db.readData();
    }
  }

//get list
  List<ExpenseItem> getOverAllExpenseList() {
    overAllExpenseList.sort();
    return overAllExpenseList;
  }

//add a expense
  void addOverAllExpenseList(ExpenseItem expenseItem) {
    overAllExpenseList.add(expenseItem);
    db.saveData(overAllExpenseList);
    notifyListeners();
  }

//remove an expense
  void removeOverAllExpenseList(ExpenseItem expenseItem) {
    overAllExpenseList.remove(expenseItem);
    db.saveData(overAllExpenseList);
    notifyListeners();
  }

//get weekdays
  String getWeekdays(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "mon";
      case 2:
        return "tue";
      case 3:
        return "wed";
      case 4:
        return "thur";
      case 5:
        return "fri";
      case 6:
        return "sat";
      case 7:
        return "sun";
      default:
        return "";
    }
  }

//start of week
  DateTime startOfWeekDay() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getWeekdays(today.subtract(Duration(days: i))) == "mon") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

//calculate daily expense
  Map<String, double> calculateDailyExpenseSumary() {
    Map<String, double> dailyExpenseSumary = {
// example 02/02/2023 24.5
    };
    for (var expense in overAllExpenseList) {
      String date = converttoStringFromDateTime(expense.dateTime);
      double amount = double.parse(expense.amount);
      if (dailyExpenseSumary.containsKey(date)) {
        double currentAomunt = dailyExpenseSumary[date]!;
        currentAomunt += amount;
        dailyExpenseSumary[date] = currentAomunt;
      } else {
        dailyExpenseSumary.addAll({date: amount});
      }
    }
    return dailyExpenseSumary;
  }
}
