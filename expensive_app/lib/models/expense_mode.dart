
class ExpenseItem extends Comparable<dynamic>{

String name;
String amount;
DateTime dateTime;
  ExpenseItem({required this.name,required this.amount ,required this.dateTime});
  
  @override
  int compareTo(other) {
   if (this.dateTime.isBefore(other.dateTime)){
      return 1;
    }else if(this.dateTime.isAfter(other.dateTime)){
      return -1;
    }else{
      return 0;
    }
  }
  
}