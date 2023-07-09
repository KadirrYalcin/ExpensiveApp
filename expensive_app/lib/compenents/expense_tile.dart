import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? delete;
  void Function(BuildContext)? editing;
  ExpenseTile(
      {Key? key,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.delete,
      required this.editing,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: delete,icon: Icons.delete,backgroundColor: Colors.red,),
            SlidableAction(onPressed: editing,icon: Icons.settings,backgroundColor: Colors.green,),
            ]),
      child: ListTile(
        title: Text(name),
        subtitle: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}"),
        trailing: Text("\$ $amount "),
      ),
    );
  }
}
