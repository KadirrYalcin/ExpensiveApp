import 'package:expensive_app/compenents/expense_graph.dart';
import 'package:expensive_app/compenents/expense_tile.dart';
import 'package:expensive_app/models/expense_mode.dart';
import 'package:flutter/material.dart';
import 'package:expensive_app/data/expense_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseDolarController = TextEditingController();
  final newExpenseCentController = TextEditingController();
//FloatingActionButton's save
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseDolarController.text.isNotEmpty) {
      //create an expense item for saving
      ExpenseItem expenseItem = ExpenseItem(
          name: newExpenseNameController.text,
          amount:
              "${newExpenseDolarController.text}.${newExpenseCentController.text.isNotEmpty ? newExpenseCentController.text : 00}",
          dateTime: DateTime.now());
      //save
      Provider.of<ExpenseData>(context, listen: false)
          .addOverAllExpenseList(expenseItem);
    }
    Navigator.pop(context);
    clear();
  }

  void editSave(ExpenseItem expenseItemData) {
    var expenseItem;
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseDolarController.text.isNotEmpty) {
      //create an expense item for saving
       expenseItem = ExpenseItem(
          name: newExpenseNameController.text,
          amount:
              "${newExpenseDolarController.text}.${newExpenseCentController.text.isNotEmpty ? newExpenseCentController.text : 00}",
          dateTime: expenseItemData.dateTime);
      //save
     
    } 
    Provider.of<ExpenseData>(context, listen: false)
          .addOverAllExpenseList(expenseItem??expenseItemData);
    Navigator.pop(context);
    clear();
  }

  //remove expense
  void deleteExpense(ExpenseItem expenseItem) {
    Provider.of<ExpenseData>(context, listen: false)
        .removeOverAllExpenseList(expenseItem);
  }

//editing expensive
  void editExpensive(ExpenseItem expenseItem) {
    //hint texts
    int dolar = double.parse(expenseItem.amount).toInt();
    double cent = (double.parse(expenseItem.amount) - dolar);

    int doubleToIntCent = (cent * 100).round();
    //add a new expense
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit Expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      decoration: InputDecoration(hintText: expenseItem.name),
                      controller: newExpenseNameController),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "$dolar"),
                          controller: newExpenseDolarController,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: "$doubleToIntCent"),
                          controller: newExpenseCentController,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: () {
                    editSave(expenseItem);
                    //remove old expense
                    deleteExpense(expenseItem);
                  },
                  child:const Text("Save"),
                ),
                //cancel button
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  child:const Text("Cancel"),
                ),
              ],
            ));
  }

//FloatingActionButton's cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

//clean the controller
  void clear() {
    newExpenseNameController.clear();
    newExpenseDolarController.clear();
    newExpenseCentController.clear();
  }

  //FloatingActionButton's popup
  void addExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add New Expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      decoration: const InputDecoration(hintText: "Name"),
                      controller: newExpenseNameController),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Dolar"),
                          controller: newExpenseDolarController,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Cent"),
                          controller: newExpenseCentController,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text("Save"),
                ),
                //cancel button
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareDB();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],

          //floatingActionButton
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: addExpense,
            child: const Icon(Icons.add),
          ),

          //body
          body: ListView(
            children: [
              //expense graph
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpenseGraph(startOfWeek: value.startOfWeekDay()),
              ),

              //expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getOverAllExpenseList().length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpenseTile(
                    name: value.getOverAllExpenseList()[index].name,
                    amount: value.getOverAllExpenseList()[index].amount,
                    dateTime: value.getOverAllExpenseList()[index].dateTime,
                    delete: (p0) =>
                        deleteExpense(value.getOverAllExpenseList()[index]),
                    editing: (p0) =>
                        editExpensive(value.getOverAllExpenseList()[index]),
                  );
                },
              ),
            ],
          )),
    );
  }
}
