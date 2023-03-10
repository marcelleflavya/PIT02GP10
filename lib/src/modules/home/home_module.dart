import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gastos_app/src/firebase/firebase_collections.dart';
import 'package:gastos_app/src/modules/authentication/repositories/auth_repository.dart';
import 'package:gastos_app/src/modules/home/controllers/home_page_controller.dart';
import 'package:gastos_app/src/modules/home/home_page.dart';
import 'package:gastos_app/src/modules/home/home_routes.dart';
import 'package:gastos_app/src/modules/home/modules/profile/profile_module.dart';
import 'package:gastos_app/src/modules/home/pages/expense/create_expense/controllers/create_expense_page_controller.dart';
import 'package:gastos_app/src/modules/home/pages/expense/create_expense/create_expense_page.dart';
import 'package:gastos_app/src/modules/home/pages/expense/list_expenses/expense_list_page.dart';
import 'package:gastos_app/src/modules/home/pages/profit/create_profit/create_profit_page.dart';
import 'package:gastos_app/src/modules/home/pages/profit/profit_list/profit_list_page.dart';
import 'package:gastos_app/src/repositories/expense/expense_repository.dart';
import 'package:gastos_app/src/repositories/expense/expense_repository_firestore.dart';
import 'package:gastos_app/src/repositories/profit/profit_repository.dart';
import 'package:gastos_app/src/repositories/profit/profit_repository_firestore.dart';
import 'package:gastos_app/src/repositories/user_repository.dart';
import 'package:gastos_app/src/repositories/user_repository_firebase.dart';

import 'pages/expense/list_expenses/controllers/expense_list_page_controller.dart';
import 'pages/profit/create_profit/controllers/create_profit_page_controller.dart';
import 'pages/profit/profit_list/controllers/profit_list_page_controller.dart';

const String _moduleName = 'home/';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<ProfitRepository>(
          (i) => ProfitRepositoryFirestore(),
        ),
        Bind.lazySingleton<ExpenseRepository>(
          (i) => ExpenseRepositoryFirestore(),
        ),
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryFirebase(
            collection: i.get<FirebaseFirestore>().collection(
                  FirebaseCollection.users,
                ),
          ),
        ),
        Bind.singleton<HomePageController>(
          (i) => HomePageController(
            authRepository: i.get<AuthRepository>(),
            profitRepository: i.get<ProfitRepositoryFirestore>(),
            expenseRepository: i.get<ExpenseRepositoryFirestore>(),
            userRepository: i.get<UserRepository>(),
          ),
        ),
        Bind.factory(
          (i) => ProfitListPageController(
            authRepository: i.get<AuthRepository>(),
            profitRepository: i.get<ProfitRepositoryFirestore>(),
          ),
        ),
        Bind.factory(
          (i) => CreateProfitPageController(
            authRepository: i.get<AuthRepository>(),
            profitRepository: i.get<ProfitRepositoryFirestore>(),
          ),
        ),
        Bind.factory(
          (i) => ExpenseListPageController(
            authRepository: i.get<AuthRepository>(),
            expenseRepository: i.get<ExpenseRepositoryFirestore>(),
          ),
        ),
        Bind.factory(
          (i) => CreateExpensePageController(
            authRepository: i.get<AuthRepository>(),
            expenseRepository: i.get<ExpenseRepositoryFirestore>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          routeNameFormatter(HomeRoutes.main),
          child: (context, _) => const HomePage(),
        ),
        ChildRoute(
          routeNameFormatter(HomeRoutes.createExpense),
          child: (context, _) => const CreateExpensePage(),
        ),
        ChildRoute(
          routeNameFormatter(HomeRoutes.createProfit),
          child: (context, _) => const CreateProfitPage(),
        ),
        ChildRoute(
          routeNameFormatter(HomeRoutes.listExpense),
          child: (context, _) => const ExpenseListPage(),
        ),
        ChildRoute(
          routeNameFormatter(HomeRoutes.listProfit),
          child: (context, _) => const ProfitListPage(),
        ),
        ModuleRoute(
          routeNameFormatter(HomeRoutes.profile),
          module: ProfileModule(),
        ),
      ];

  String routeNameFormatter(String route) => route.replaceAll(_moduleName, '');
}
