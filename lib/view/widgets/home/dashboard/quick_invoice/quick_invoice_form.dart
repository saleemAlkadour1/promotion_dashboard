// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/quick_invoice/title_text_field.dart';

class QuickInvoiceForm extends StatelessWidget {
  const QuickInvoiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TitleTextField(
                  title: 'Customer name', hintTextField: 'Type customer name'),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TitleTextField(
                  title: 'Customer Email',
                  hintTextField: 'Type customer email'),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: TitleTextField(
                  title: 'Item name', hintTextField: 'Type customer name'),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child:
                    TitleTextField(title: 'Item mount', hintTextField: 'USD')),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                title: 'Add more details',
                backgroundColor: AppColors.white,
                textColor: AppColors.color_4EB7F2,
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Expanded(
              child: CustomButton(
                title: 'Send Money',
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    );
  }
}
