import 'package:gastos_app/src/modules/home/models/expense_model.dart';
import 'package:gastos_app/src/modules/home/models/profit_model.dart';

class MockedData {
  static final mockedProfits = [
    ProfitModel(
      title: "Projeto 1",
      value: 400.00,
      createdAt: DateTime(2022, 10, 24),
    ),
    ProfitModel(
      title: "Vendas",
      value: 328.95,
      createdAt: DateTime(2022, 11, 25),
    ),
    ProfitModel(
      title: "Projeto 2",
      value: 65.90,
      createdAt: DateTime(2022, 10, 28),
    ),
    ProfitModel(
      title: "Projeto 3",
      value: 65.90,
      createdAt: DateTime(2022, 11, 5),
    ),
    ProfitModel(
      title: "Projeto 4",
      value: 65.90,
      createdAt: DateTime(2022, 10, 1),
    ),
  ];

  static final mockedExpenses = [
    ExpenseModel(
      title: "Padaria",
      value: 30.0,
      createdAt: DateTime(2022, 10, 12),
    ),
    ExpenseModel(
      title: "Farmácia",
      value: 68.90,
      createdAt: DateTime(2022, 10, 21),
    ),
    ExpenseModel(
      title: "Jantar com nome grande para testar como fica na tela",
      value: 1050.0,
      createdAt: DateTime(2022, 10, 22),
    ),
    ExpenseModel(
      title: "Preisteichon",
      value: 3500.0,
      createdAt: DateTime(2022, 11, 22),
    ),
  ];
}
