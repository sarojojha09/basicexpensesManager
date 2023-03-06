import 'package:expenses_manager/expenses.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Expenses blank = Expenses(0, "", 0, DateTime.now());
          addupdateExpenses(context, true, blank);
        },
      ),
      appBar: AppBar(
        title: Text("Expenses Tracker \nTotal: ${getTotalExpenses()}"),
      ),
      body: expenses.isEmpty
          ? const Center(
              child: Text(
                "No expenses found click + to add",
                style: TextStyle(fontSize: 27),
              ),
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(expenses[index].id.toString()),
                  ),
                  title: Text(expenses[index].category),
                  subtitle: Text("Rs ${expenses[index].amount}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          DateTime date = DateTime.now();
                          Expenses ex = Expenses(
                              expenses[index].id,
                              expenses[index].category,
                              expenses[index].amount,
                              date);

                          addupdateExpenses(context, false, ex);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            deleteExpenses(expenses[index].id);
                          });
                        },
                      ),
                    ],
                  ),
                );
              }),
    );
  }

  Future<dynamic> addupdateExpenses(
      BuildContext context, bool isAdded, Expenses ex) {
    if (!isAdded) {
      categoryController.text = ex.category;
      amountController.text = ex.amount.toString();
    }
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              scrollable: true,
              title: isAdded
                  ? const Text("Add new Expenses")
                  : const Text("Edit Expenses"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                        labelText: "Enter Category", hintText: "Recharge"),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: const InputDecoration(
                        labelText: "Enter Amount", hintText: "300"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (isAdded) {
                      if (amountController.text.isEmpty ||
                          categoryController.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        expenses.add(Expenses(
                            getId(),
                            categoryController.text,
                            double.parse(amountController.text),
                            DateTime.now()));
                      });
                    } else {
                      Expenses updateEx = Expenses(
                          ex.id,
                          categoryController.text,
                          double.parse(amountController.text),
                          DateTime.now());
                      editExpenses(ex.id, updateEx);

                      setState(() {});
                    }

                    amountController.clear();
                    categoryController.clear();
                    Navigator.of(ctx).pop();
                  },
                  child: isAdded ? const Text("Add") : const Text("Update"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }
}
