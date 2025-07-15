import 'package:amazon_clone/common/widgets/custom_buttton.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/farmer_Authservices.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class FarmerAuth extends StatefulWidget {
  static const String routeName = '/farmer-auth';
  const FarmerAuth({super.key});

  @override
  State<FarmerAuth> createState() => _FarmerAuthState();
}

class _FarmerAuthState extends State<FarmerAuth> {
  Auth groupValue = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FarmerAuthService authService = FarmerAuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void signupUser() {
    authService.signUpFarmer(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
    );
  }

  void signInuser() {
    authService.signInFarmer(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ' Welcome to Farmer...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/Farmer.png'),
                    height: 150,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Cretae an account',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      leading: Radio(
                          activeColor: GlobalVariables.secondaryColor,
                          value: Auth.signup,
                          groupValue: groupValue,
                          onChanged: (Auth? val) {
                            setState(() {
                              groupValue = val!;
                            });
                          }),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Sign in',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      leading: Radio(
                          activeColor: GlobalVariables.secondaryColor,
                          value: Auth.signin,
                          groupValue: groupValue,
                          onChanged: (Auth? val) {
                            setState(() {
                              groupValue = val!;
                            });
                          }),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              if (groupValue == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: <Widget>[
                          CustomTextfield(
                              controller: _nameController, hintText: 'Name'),
                          const SizedBox(height: 10),
                          CustomTextfield(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomTextfield(
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(height: 10),
                          CustomTextfield(
                              controller: _phoneController,
                              hintText: 'Contact Number'),
                          const SizedBox(height: 10),
                          CustomTextfield(
                              controller: _addressController,
                              hintText: 'address',
                              Maxlen: 5),
                          const SizedBox(height: 10),
                          CustomButtton(
                              text: 'Sign up',
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signupUser();
                                }
                              })
                        ],
                      )),
                ),
              if (groupValue == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: <Widget>[
                          CustomTextfield(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomTextfield(
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(height: 10),
                          CustomButtton(
                              text: 'Sign In',
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInuser();
                                }
                              })
                        ],
                      )),
                ),
            ],
          ),
        )),
      ),
    );
  }
}
