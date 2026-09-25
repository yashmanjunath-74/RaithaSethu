import 'package:RaithaSethu/common/widgets/custom_buttton.dart';
import 'package:RaithaSethu/common/widgets/rating.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/product_deatails/services/product_services.dart';
import 'package:RaithaSethu/features/search/screens/search_screen.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDeatailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final ProductModel product;
  const ProductDeatailsScreen({super.key, required this.product});

  @override
  State<ProductDeatailsScreen> createState() => _ProductDeatailsScreenState();
}

class _ProductDeatailsScreenState extends State<ProductDeatailsScreen> {
  final ProductServices productServices = ProductServices();
  double avgrating = 0;
  double myRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalrating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalrating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalrating != 0) {
      avgrating = totalrating / widget.product.rating!.length;
    } else {
      avgrating = 0;
    }
  }

  void NavigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void addToCart() {
    productServices.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.surfaceColor,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Carousel
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  CarouselSlider(
                    items: widget.product.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.network(
                            i,
                            fit: BoxFit.contain,
                            height: 260,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 300,
                      autoPlayCurve: Curves.easeInOutCubic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Product Info Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(GlobalVariables.radiusLg),
                boxShadow: GlobalVariables.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating & ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Rating(rating: avgrating),
                      Text(
                        widget.product.id ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          color: GlobalVariables.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Product Name
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: GlobalVariables.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: GlobalVariables.primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(
                          GlobalVariables.radiusMd),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '₹${widget.product.price}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'per kg',
                          style: TextStyle(
                            fontSize: 14,
                            color: GlobalVariables.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Info Pills
                  Row(
                    children: [
                      _InfoPill(
                        icon: Icons.calendar_today_rounded,
                        label: 'Harvest: ${widget.product.expectedHarvestDate}',
                        color: GlobalVariables.successColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _InfoPill(
                        icon: Icons.inventory_2_outlined,
                        label: 'Available: ${widget.product.quantity} kg',
                        color: const Color(0xFF3B82F6),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Description Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(GlobalVariables.radiusLg),
                boxShadow: GlobalVariables.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: GlobalVariables.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: GlobalVariables.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  CustomButtton(text: 'Buy Now', onTap: () {}),
                  const SizedBox(height: 10),
                  CustomButtton(
                    text: 'Add To Cart',
                    onTap: addToCart,
                    color: GlobalVariables.accentGold,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Rating Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(GlobalVariables.radiusLg),
                boxShadow: GlobalVariables.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rate This Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: GlobalVariables.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: RatingBar.builder(
                      initialRating: myRating,
                      maxRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemPadding:
                          const EdgeInsets.symmetric(horizontal: 6),
                      itemBuilder: (context, _) {
                        return const Icon(
                          Icons.star_rounded,
                          color: GlobalVariables.accentGold,
                        );
                      },
                      onRatingUpdate: (Rating) {
                        productServices.rateProduct(
                            context: context,
                            product: widget.product,
                            rating: Rating);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(GlobalVariables.radiusSm),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
