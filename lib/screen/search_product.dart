import '../model/products.dart';
import '../pagelink/product_linker.dart';
import '../screen/detailpage.dart';
import '../widgets/singeproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductLinker P_Provider = Provider.of<ProductLinker>(context);
    List<Product> searchCategory = P_Provider.searchProductList(query);

    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailScreen(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    name: e.name,
                    price: e.price,
                  ),
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   ProductLinker P_Provider = Provider.of<ProductLinker>(context);
    List<Product> searchCategory =P_Provider.searchProductList(query);
    return GridView.count(
        childAspectRatio: 0.76,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailScreen(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    name: e.name,
                    price: e.price,
                  ),
                ))
            .toList());
  }
}
