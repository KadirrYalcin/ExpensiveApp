import 'package:expensive_app/bargraph/bar_graph.dart';
import 'package:expensive_app/data/expense_data.dart';
import 'package:expensive_app/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseGraph extends StatelessWidget {
  DateTime startOfWeek;
  ExpenseGraph({Key? key, required this.startOfWeek}) : super(key: key);

  //bars max high
  double calculateMaxY(
    value,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  ) {
    List values = [
      value.calculateDailyExpenseSumary()[monday] ?? 0,
      value.calculateDailyExpenseSumary()[tuesday] ?? 0,
      value.calculateDailyExpenseSumary()[wednesday] ?? 0,
      value.calculateDailyExpenseSumary()[thursday] ?? 0,
      value.calculateDailyExpenseSumary()[friday] ?? 0,
      value.calculateDailyExpenseSumary()[saturday] ?? 0,
      value.calculateDailyExpenseSumary()[sunday] ?? 0,
    ];
    values.sort();
    double max = double.parse(values.last.toString()) ;
    return max < 200 ? 200 : max;
  }

//week total
  String total(
    value,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  ) {
    List values = [
      value.calculateDailyExpenseSumary()[monday] ?? 0,
      value.calculateDailyExpenseSumary()[tuesday] ?? 0,
      value.calculateDailyExpenseSumary()[wednesday] ?? 0,
      value.calculateDailyExpenseSumary()[thursday] ?? 0,
      value.calculateDailyExpenseSumary()[friday] ?? 0,
      value.calculateDailyExpenseSumary()[saturday] ?? 0,
      value.calculateDailyExpenseSumary()[sunday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

//find max expense
  double maxExpense(
    value,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  ) {
    List values = [
      value.calculateDailyExpenseSumary()[monday] ?? 0,
      value.calculateDailyExpenseSumary()[tuesday] ?? 0,
      value.calculateDailyExpenseSumary()[wednesday] ?? 0,
      value.calculateDailyExpenseSumary()[thursday] ?? 0,
      value.calculateDailyExpenseSumary()[friday] ?? 0,
      value.calculateDailyExpenseSumary()[saturday] ?? 0,
      value.calculateDailyExpenseSumary()[sunday] ?? 0,
    ];
    values.sort();
    return double.parse(values.last.toString());
  }

  @override
  Widget build(BuildContext context) {
    String monday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 3)));
    String friday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        converttoStringFromDateTime(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //total expense
                    const Text(
                      "Week Total:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        "\$ ${total(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday)}")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //weekly hightest expense 
                Row(
                  children: [
                   const Text(
                      "Daily Hightest Expense:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),  
                    const SizedBox(
                      width: 10,
                    ),
                    Text("\$ ${maxExpense(value, monday, tuesday, wednesday, thursday,
                            friday, saturday, sunday)
                        .toStringAsFixed(2)}"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMaxY(value, monday, tuesday, wednesday, thursday,
                  friday, saturday, sunday),
              monAmount: value.calculateDailyExpenseSumary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSumary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSumary()[wednesday] ?? 0,
              thurAmount: value.calculateDailyExpenseSumary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSumary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSumary()[saturday] ?? 0,
              sunAmount: value.calculateDailyExpenseSumary()[sunday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
