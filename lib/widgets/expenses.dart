import 'package:expense_tracker/widgets/expense_form/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
        title: "Flutter Course",
        amount: 89.9,
        date: DateTime.parse("2023-06-02"),
        category: Category.education),
    Expense(
        title: "Makis - Salida con panas",
        amount: 99.9,
        date: DateTime.parse("2023-06-05"),
        category: Category.food)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onSave: addNewExpense),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
      ),
    );
  }

  void addNewExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
    print(
        "${formatter.format(expense.date)} | [${expense.category.name.toUpperCase()}] ${expense.title}: S/ ${expense.amount.toStringAsFixed(2)} ");
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text("Expense removed: ${expense.title}"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expenses found. Star adding some!"),
    );
    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expense Tracker!"),
        primary: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: screenWidth <= 600
          ? Column(
              children: [
                Chart(
                  expenses: _expensesList,
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _expensesList,
                  ),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
