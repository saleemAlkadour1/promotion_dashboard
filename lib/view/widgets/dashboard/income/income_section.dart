import 'package:flutter/material.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_background_container.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/income/income_section_body.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/income/income_section_header.dart';

class IncomeSection extends StatelessWidget {
  const IncomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBackgroundContainer(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          IncomeSectionHeader(),
          IncomeSectionBody(),
        ],
      ),
    );
  }
}
