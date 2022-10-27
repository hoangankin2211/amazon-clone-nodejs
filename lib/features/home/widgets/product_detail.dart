import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/home/controller/home_controller.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final HomeController homeController = Get.find<HomeController>();

  bool _isLoading = false;

  void _addToCart() async {
    setState(() {
      _isLoading = true;
    });
    await homeController.addProductToCart(widget.product);
    setState(() {
      _isLoading = false;
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.product.id!,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 100,
                          child: Row(children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: Colors.yellow[800],
                                size: 18,
                              )
                          ]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: Get.height * 0.4,
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.product.images[0]),
                      ),
                    ),
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(
                          text: 'Deal Price: ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '\$${widget.product.price}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.product.description),
                    ),
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        title: 'Buy Now',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        title: 'Add to Cart',
                        onTap: _addToCart,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 1),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Rate The Product',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                            size: 40,
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
