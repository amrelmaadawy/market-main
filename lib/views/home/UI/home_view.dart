import 'package:app/core/app_colors.dart';
import 'package:app/core/components/list_of_products.dart';
import 'package:app/core/sensitive_data.dart';
import 'package:app/views/auth/logic/module/user_module.dart';
import 'package:app/views/home/UI/search_view.dart';
import 'package:app/views/home/UI/widgets/categories_list.dart';

import 'package:app/views/home/UI/widgets/search_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key,required this.userModule});
  final UserModule userModule;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController mainSearchController = TextEditingController();
  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          paymopeApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      userData: UserData(
        email:widget.userModule.email, // Optional: Defaults to 'NA'

        name: widget.userModule.name, // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        scaffoldColor: AppColors.kScaffoldColor, // Default: Colors.white
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        appBarForegroundColor: AppColors.kWhiteColor, // Default: Colors.white
        textStyle: TextStyle(), // Default: TextStyle()
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: AppColors.kGreyColor, // Default: Colors.grey
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          SearchFormField(
            searchController: mainSearchController,
            onPressed: () {
              if (mainSearchController.text.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchView(query: mainSearchController.text);
                }));
                mainSearchController.clear();
              }
            },
          ),
          const SizedBox(height: 16),
          Image.asset('assets/images/buy.jpg'),
          const SizedBox(height: 16),
          const Text(
            'Popular Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.kBlackColor,
            ),
          ),
          const SizedBox(height: 16),
          const CategoriesList(),
          const SizedBox(
            height: 16,
          ),
          const Text('Recntly products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.kBlackColor,
              )),
          const SizedBox(
            height: 16,
          ),
          const ListOfProducts()
        ],
      ),
    );
  }

  @override
  void dispose() {
    mainSearchController.dispose();
    super.dispose();
  }
}
