import 'package:RaithaSethu/common/widgets/custom_buttton.dart';
import 'package:RaithaSethu/common/widgets/custom_textfield.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth groupValue = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signupUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInuser() {
    authService.signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.surfaceColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
              boxShadow: GlobalVariables.softShadow,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 16, color: GlobalVariables.textPrimary),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),

                // Hero Image
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: GlobalVariables.primaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: const AssetImage('assets/images/Customer.png'),
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  'Welcome, Customer!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: GlobalVariables.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sign in to access fresh produce directly from farmers',
                  style: TextStyle(
                    fontSize: 14,
                    color: GlobalVariables.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Toggle Tabs
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(GlobalVariables.radiusMd),
                    boxShadow: GlobalVariables.softShadow,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => groupValue = Auth.signin),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: groupValue == Auth.signin
                                  ? GlobalVariables.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariables.radiusMd),
                            ),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: groupValue == Auth.signin
                                    ? Colors.white
                                    : GlobalVariables.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => groupValue = Auth.signup),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: groupValue == Auth.signup
                                  ? GlobalVariables.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariables.radiusMd),
                            ),
                            child: Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: groupValue == Auth.signup
                                    ? Colors.white
                                    : GlobalVariables.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Forms
                if (groupValue == Auth.signup)
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextfield(
                          controller: _nameController,
                          hintText: 'Full Name',
                          prefixIcon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 14),
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 14),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        const SizedBox(height: 20),
                        CustomButtton(
                          text: 'Create Account',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signupUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                if (groupValue == Auth.signin)
                  Form(
                    key: _signInFormKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 14),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        const SizedBox(height: 20),
                        CustomButtton(
                          text: 'Sign In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInuser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
