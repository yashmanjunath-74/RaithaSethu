import 'package:RaithaSethu/common/widgets/loader.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/home/service/home_service.dart';
import 'package:RaithaSethu/features/product_deatails/screen/product_deatails_screen.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  ProductModel? product;

  HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOftheDay();
  }

  void fetchDealOftheDay() async {
    product = await homeService.fetchDealOftheDay(context: context);
  }

  void navigateToProductDetails() {
    Navigator.pushNamed(context, ProductDeatailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.productName.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToProductDetails,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(GlobalVariables.radiusLg),
                      boxShadow: GlobalVariables.softShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: GlobalVariables.cardGradient,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  GlobalVariables.radiusLg),
                              topRight: Radius.circular(
                                  GlobalVariables.radiusLg),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: GlobalVariables.primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariables.radiusSm),
                                ),
                                child: const Icon(
                                  Icons.local_offer_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Deal of the Day',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: GlobalVariables.textPrimary,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: GlobalVariables.errorColor,
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariables.radiusFull),
                                ),
                                child: const Text(
                                  '🔥 HOT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Main Image
                        ClipRRect(
                          child: Image.network(
                            product!.images[0],
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Price & Name
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '₹${product!.price}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: GlobalVariables.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'per kg',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: GlobalVariables.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product!.productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: GlobalVariables.textPrimary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Thumbnail Gallery
                        if (product!.images.length > 1)
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: product!.images.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4),
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariables.radiusSm),
                                    border: Border.all(
                                      color: GlobalVariables.dividerColor,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariables.radiusSm - 1),
                                    child: Image.network(
                                      product!.images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        // See All
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View Details',
                                style: TextStyle(
                                  color: GlobalVariables.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: GlobalVariables.primaryColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
