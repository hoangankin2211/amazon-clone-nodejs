import 'package:amazon/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../home/controller/home_controller.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  final homeController = Get.find<HomeController>();

  bool isLoading = false;

  String addressToBeUsed = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {}

  void onGooglePayResult(res) {}

  void payPressed(String addressFromProvider) async {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: 'ERROR',
        message: 'Loi roi bro',
      ));
    }

    setState(() {
      isLoading = true;
    });

    bool result1 = await homeController.saveUserAddress(addressToBeUsed);
    bool result2 = await homeController.orderCart(
        widget.totalAmount, GlobalVariables.userInfo!.address);
    setState(() {
      isLoading = false;
    });
    Get.back();
    if (result2 == false) {
      Get.showSnackbar(const GetSnackBar(
        title: 'ERROR',
        message: 'Something error when change user address',
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = GlobalVariables.userInfo!.address;

    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (address.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                address,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Form(
                      key: _addressFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: flatBuildingController,
                            hintText: 'Flat, House no, Building',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: areaController,
                            hintText: 'Area, Street',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: pincodeController,
                            hintText: 'Pincode',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: cityController,
                            hintText: 'Town/City',
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    CustomButton(
                        onTap: () => payPressed(address), title: 'Pay'),
                  ],
                ),
              ),
            ),
          );
  }
}
