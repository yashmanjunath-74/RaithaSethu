import 'package:RaithaSethu/common/widgets/loader.dart';
import 'package:RaithaSethu/features/account/widgets/single_product.dart';
import 'package:RaithaSethu/features/admin/screen/add_product_screen.dart';
import 'package:RaithaSethu/features/admin/services/farmer_services.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel>? ProductList;
  final FarmerServices farmerServices = FarmerServices();

  @override
  void initState() {
    super.initState();
    fetchallproduct();
  }

  fetchallproduct() async {
    ProductList = await farmerServices.fetchAllproduct(context);
    setState(() {});
  }

  void deleteProduct(ProductModel product, int index) {
    farmerServices.deleteProduct(
        context: context,
        Product: product,
        Onsuccess: () {
          ProductList!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return ProductList == null
        ? Loader()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: 10),
              child: GridView.builder(
                  itemCount: ProductList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final productData = ProductList![index];
                    return Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: SingleProduct(
                              image: productData.images[0],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    productData.productName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteProduct(productData, index);
                                  },
                                  icon: Icon(Icons.delete_outline),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              tooltip: 'Add product',
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
