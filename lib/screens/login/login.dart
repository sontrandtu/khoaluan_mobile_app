import 'package:flutter/material.dart';
import 'package:khoaluan_mobile_app/screens/login/login_view_model.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              onChanged: (value){
                viewModel.email = value;
              },
              decoration: InputDecoration(
                label: Text("Email"),
              ),
            ),
            TextFormField(
              controller: passwordController,
              onChanged: (value){
                viewModel.password = value;
              },
              decoration: InputDecoration(
                label: Text("Email"),
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  viewModel.login(
                    successCallback: (message){
                      print(message);
                    }
                  );
                }, child: Text('Đăng nhập')
            )
          ],
        ),
      ),
    );
  }
}
