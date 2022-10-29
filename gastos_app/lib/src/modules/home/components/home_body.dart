import 'package:flutter/material.dart';
import 'package:gastos_app/src/modules/home/components/expenses_resumed_list.dart';
import 'package:gastos_app/src/modules/home/components/profile_box/profile_currency_box.dart';
import 'package:gastos_app/src/modules/home/components/profit_resumed_list.dart';
import 'package:gastos_app/src/modules/home/models/expense_model.dart';
import 'package:gastos_app/src/modules/home/models/profit_model.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalOutcome = mockedExpenses.fold(
      0.0,
      (total, element) => total + element.value,
    );
    final totalIncome = mockedProfits.fold(
      0.0,
      (total, element) => total + element.value,
    );

    final monthStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        );

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        ProfileCurrencyBox(
          totalIncome: totalIncome,
          totalOutcome: totalOutcome,
          username: "usuário",
        ),
        const SizedBox(height: 10),
        Text(
          "Outubro",
          style: monthStyle,
        ),
        const SizedBox(height: 10),
        const Divider(),
        ProfitResumedList(
          onTap: () {},
        ),
        const Divider(),
        ExpensesResumedList(
          onTap: () {},
        ),
        const Divider(),
        const Spacer(),
        IconButton(
          iconSize: 56,
          icon: const Icon(
            Icons.add_circle_outline,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
