import 'package:flutter/material.dart';
import 'package:gastos_app/src/modules/authentication/repositories/auth_repository.dart';
import 'package:gastos_app/src/modules/home/pages/expense/list_expenses/controllers/expenses_page_states.dart';
import 'package:gastos_app/src/repositories/expense/expense_repository.dart';

class ExpenseListPageController {
  final AuthRepository authRepository;
  ExpenseListPageController({
    required this.authRepository,
  });

  final expensesPageStateNotifier = ValueNotifier<ExpenseListPageState>(
    ExpenseListPageStateEmpty(),
  );

  ExpenseListPageState get state => expensesPageStateNotifier.value;
  set state(ExpenseListPageState state) {
    expensesPageStateNotifier.value = state;
  }

  Future<void> getExpensesList() async {
    state = ExpenseListPageStateLoading();
    final expenseRepository = SharedPreferencesExpenseRepository();

    await Future.delayed(const Duration(seconds: 2));

    final loggedUser = authRepository.currentUser;

    if (loggedUser != null) {
      try {
        final expenses = await expenseRepository.listAll(
          loggedUserId: loggedUser.uid,
        );

        if (expenses == null || expenses.isEmpty) {
          state = ExpenseListPageStateEmpty();
          return;
        }
        expenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        state = ExpenseListPageStateSuccess(
          expensesList: expenses,
          // loggedUser: loggedUser,
        );
      } catch (e) {
        state = ExpenseListPageStateError(error: e.toString());
      }
    } else {
      // await authRepository().logout();
    }
  }
}
