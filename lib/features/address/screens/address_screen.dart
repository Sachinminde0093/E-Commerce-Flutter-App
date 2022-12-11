import 'package:e_commerce_app/common/widgets/custome_textfield.dart';
import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/features/home/widgets/addressbar.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  final String sum;
  static const routeName = '/address_screen';
  const AddressScreen({super.key, required this.sum});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String? userAddress = "ss";

  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _streatController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            backgroundColor: GlobalVariables.selectedNavBarColor,
            title: const Text("Address"),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (userAddress != null) const AddressBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeTextField(
                        controller: _homeController,
                        hint: "Home",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeTextField(
                        controller: _streatController,
                        hint: "Streat",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeTextField(
                        controller: _stateController,
                        hint: "State",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeTextField(
                        controller: _pinCodeController,
                        hint: "Pin Code",
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
