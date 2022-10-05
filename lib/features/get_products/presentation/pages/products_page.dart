import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/injection_container.dart' as di;
import '../../../../core/theme/colors_theme.dart';
import '../../../../core/theme/dimensions.dart';
import '../bloc/bloc.dart';
import '../widgets/product_widget.dart';
import '../widgets/products_loading_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.grey,
      appBar: AppBar(title: const Text("Store App")),
      body: BlocProvider(
        create: (_) => di.sl<ProductsBloc>()..add(LoadProductsEvent()),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const ProductsLoadingWidget();
            } else if (state is ProductsLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumPadding,
                          vertical: Dimensions.minPadding),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ProductWidget(product: state.products[index]),
                      itemCount: state.products.length,
                    ),
                  ),
                ],
              );
            } else if (state is ProductsErrorState) {
              return Text(state.message);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
