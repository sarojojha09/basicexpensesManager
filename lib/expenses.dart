class Expenses {
  int id;
  String category;
  double amount;
  DateTime date;

  Expenses(this.id, this.category, this.amount, this.date);
}

List<Expenses> expenses = [];

getId() {
  if (expenses.isEmpty) {
    return 1;
  } else {
    return expenses.length + 1;
  }
}

getTotalExpenses() {
  double amount = 0;
  for (Expenses e in expenses) {
    amount += e.amount;
  }
  return amount;
}

deleteExpenses(int id) {
  if (expenses.isEmpty) {
    return;
  } else {
    expenses.removeWhere((element) => element.id == id);
  }
}

editExpenses(int id, Expenses ex) {
  if (expenses.isEmpty) {
    return;
  } else {
    //use where to get the index of the element
    int index = expenses.indexWhere((element) => element.id == id);
    expenses[index].category = ex.category;
    expenses[index].amount = ex.amount;
    expenses[index].date = ex.date;
  }
}
