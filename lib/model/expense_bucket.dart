import 'package:expense_tracker/model/expense.dart';

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => category == expense.category)
            .toList();

  double get totalExpense {
    double total = 0;
    for (final expense in expenses) {
      total += expense.amount;
    }
    return total;
  }
}
