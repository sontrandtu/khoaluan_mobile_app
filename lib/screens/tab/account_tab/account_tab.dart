import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/tab/account_tab/account_view_model.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AccountViewModel>(
          builder: (context,viewModel, child) =>  Container(
            child: Text(viewModel.text),
          ),
        ),
      ),
    );
  }
}
