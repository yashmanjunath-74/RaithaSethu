import 'package:RaithaSethu/common/widgets/loader.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/home/widgets/address_box.dart';
import 'package:RaithaSethu/features/product_deatails/screen/product_deatails_screen.dart';
import 'package:RaithaSethu/features/search/services/search_services.dart';
import 'package:RaithaSethu/features/search/widget/search_product.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? productList;

  SearchServices searchServices = SearchServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchsearchProduct();
  }

  void fetchsearchProduct() async {
    productList = await searchServices.fetchSearchProduct(
        searchQuery: widget.searchQuery, context: context);
    setState(() {});
  }

  void NavigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(GlobalVariables.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    onFieldSubmitted: NavigateToSearchScreen,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: GlobalVariables.textLight,
                        size: 22,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 11),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(GlobalVariables.radiusMd),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(GlobalVariables.radiusMd),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search RaithaSethu',
                      hintStyle: TextStyle(
                        color: GlobalVariables.textLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(GlobalVariables.radiusMd),
                ),
                child: const Icon(
                  Icons.mic_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : productList!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: GlobalVariables.textLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: GlobalVariables.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Try a different search term',
                        style: TextStyle(
                          fontSize: 13,
                          color: GlobalVariables.textLight,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const AddressBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            '${productList!.length} results',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: GlobalVariables.textSecondary,
                            ),
                          ),
                          Text(
                            ' for "${widget.searchQuery}"',
                            style: TextStyle(
                              fontSize: 14,
                              color: GlobalVariables.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: productList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, ProductDeatailsScreen.routeName,
                                arguments: productList![index]),
                            child: SearchProduct(
                              product: productList![index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
