// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/data/model/product_model.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/custom_dawer.dart';
import 'package:promotion_dashboard/view/widgets/products/sf_data_grid_products.dart';
import 'package:promotion_dashboard/view/widgets/products/top_section_in_products.dart';

class ProductsDesktopLayout extends StatefulWidget {
  const ProductsDesktopLayout({super.key});

  @override
  State<ProductsDesktopLayout> createState() => _ProductsDesktopLayoutState();
}

class _ProductsDesktopLayoutState extends State<ProductsDesktopLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 32,
        ),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TopSectionInProducts(),
              ),
              Expanded(
                flex: 7,
                child: SFDataGridProducts(
                  products: List.generate(
                      50,
                      (index) => ProductModel(
                          id: index.toString(),
                          name: 'Name $index',
                          type: 'type $index',
                          price: 'Proce $index')),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
