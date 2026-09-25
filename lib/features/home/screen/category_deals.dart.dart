import 'package:RaithaSethu/common/widgets/loader.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/home/service/home_service.dart';
import 'package:RaithaSethu/features/product_deatails/screen/product_deatails_screen.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:flutter/material.dart';

class CategoryDeals extends StatefulWidget {
  final String categary;
  static const String routeName = '/categary-deals';
  const CategoryDeals({super.key, required this.categary});

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  HomeService homeService = HomeService();
  List<ProductModel> productList = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchCategaryList();
  }

  fetchCategaryList() async {
    productList = await homeService.fetchCategaryProduct(
        context: context, category: widget.categary);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.categary,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: productList.isEmpty
          ? const Loader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: GlobalVariables.primaryColor
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                                GlobalVariables.radiusSm),
                          ),
                          child: Icon(
                            Icons.category_rounded,
                            color: GlobalVariables.primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categary,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: GlobalVariables.textPrimary,
                              ),
                            ),
                            Text(
                              '${productList.length} products available',
                              style: TextStyle(
                                fontSize: 13,
                                color: GlobalVariables.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Product Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        var product = productList[index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ProductDeatailsScreen.routeName,
                              arguments: product),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariables.radiusMd),
                              boxShadow: GlobalVariables.softShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          GlobalVariables.radiusMd),
                                      topRight: Radius.circular(
                                          GlobalVariables.radiusMd),
                                    ),
                                    child: Image.network(
                                      product.images[0],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Info
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: GlobalVariables.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₹${product.price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: GlobalVariables.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
