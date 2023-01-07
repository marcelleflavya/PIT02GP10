import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gastos_app/src/core/app_colors.dart';
import 'package:gastos_app/src/modules/home/pages/profit/create_profit/controllers/create_profit_controller.dart';
import 'package:gastos_app/src/modules/home/pages/profit/create_profit/controllers/create_profit_page_state.dart';
import 'package:gastos_app/src/shared/components/custom_date_picker.dart';
import 'package:gastos_app/src/shared/components/custom_elevated_button.dart';
import 'package:gastos_app/src/shared/components/custom_loading_icon.dart';
import 'package:gastos_app/src/shared/components/custom_text_field.dart';
import 'package:gastos_app/src/shared/utils/app_notifications.dart';
import 'package:validatorless/validatorless.dart';

class CreateProfitPage extends StatefulWidget {
  const CreateProfitPage({super.key});

  @override
  State<CreateProfitPage> createState() => _CreateProfitPageState();
}

class _CreateProfitPageState extends State<CreateProfitPage> {
  final formKey = GlobalKey<FormState>();
  final createProfitController = Modular.get<CreateProfitPageController>();

  final valueController = MoneyMaskedTextController(
    leftSymbol: "R\$ ",
    decimalSeparator: ',',
    thousandSeparator: '.',
  );
  final descriptionController = TextEditingController();
  DateTime? chosenDate;

  @override
  void initState() {
    createProfitController.createProfitStateNotifier.addListener(() {
      if (createProfitController.state is CreateProfitPageStateSuccess) {
        Modular.to.pop(true);
      } else if (createProfitController.state is CreateProfitPageStateError) {
        final e = createProfitController.state as CreateProfitPageStateError;
        AppNotifications.errorNotificationBanner(e.object);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    createProfitController.createProfitStateNotifier.removeListener(() {});
    Modular.dispose<CreateProfitPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          color: AppColors.profitColor,
          fontSize: 32,
        );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                    ),
                    onPressed: () {
                      Modular.to.pop();
                    },
                  ),
                ),
                Text(
                  "Novo ganho",
                  style: textStyle,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                    label: "Valor do ganho",
                    filledColor: AppColors.profitColor,
                    controller: valueController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: Validatorless.multiple([
                      Validatorless.required("Necessário informar um valor"),
                      (String? value) {
                        if (value == null || value == "R\$ 0,00") {
                          return "Digite um valor válido";
                        }
                        return null;
                      },
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                    label: "Descrição",
                    filledColor: AppColors.profitColor,
                    controller: descriptionController,
                    textInputAction: TextInputAction.next,
                    validator: Validatorless.required(
                      "Necessário informar uma descrição",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomDatePicker(
                    label: "Data de recebimento",
                    onDateChange: (date) {
                      chosenDate = date;
                    },
                    validator: Validatorless.required(
                      "Necessário informar uma data",
                    ),
                    filledColor: AppColors.profitColor,
                  ),
                ),
                const SizedBox(height: 150),
                ValueListenableBuilder<CreateProfitPageState>(
                  valueListenable:
                      createProfitController.createProfitStateNotifier,
                  builder: (context, state, _) {
                    return SizedBox(
                      width: 110,
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.profitColor,
                        foregroundColor: AppColors.backgroundColor,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            createProfitController.createProfit(
                              title: descriptionController.text,
                              value: valueController.numberValue,
                              createdAt: chosenDate!,
                            );
                          }
                        },
                        child: state is CreateProfitPageStateLoading
                            ? const CustomLoadingIcon(size: 16)
                            : Text(
                                "Finalizar",
                                style: textStyle?.copyWith(
                                  fontSize: 16,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
