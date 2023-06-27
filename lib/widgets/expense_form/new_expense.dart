import 'dart:io';

import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSave});

  final void Function(Expense expense) onSave;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.others;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = (enteredAmount == null) || (enteredAmount <= 0);
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
          _showDialog();
      return;
    }
    widget.onSave(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 48, 20, keyboardSpace + 16),
              child: Column(
                children: [
                  //Title [TextField]
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration:
                                const InputDecoration(label: Text("Title")),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixText: "S/ ",
                              //labelStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        )
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text("Title")),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            value: _selectedCategory,
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                            items: (Category.values.map(
                              (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())),
                            )).toList(),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "Selected Date."
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month_outlined),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          //Amount [TextField]
                          child: TextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixText: "S/ ",
                              //labelStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "Selected Date."
                                    : formatter.format(_selectedDate!),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month_outlined),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      if (width < 600)
                        Expanded(
                          child: DropdownButton(
                            value: _selectedCategory,
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                            items: (Category.values.map(
                              (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())),
                            )).toList(),
                          ),
                        )
                      else
                        const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          print("Modal closed.");
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseDate,
                        //   onSave(
                        //     Expense(title: _titleController.text,
                        //   amount: double.parse(_amountController.text),
                        //   date: _selectedDate!,
                        //   category: _selectedCategory!)),
                        child: const Text("Save Expense"),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    });
  }
}
