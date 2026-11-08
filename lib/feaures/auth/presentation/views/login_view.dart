import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/social_login_button.dart';
import '../widgets/divider_with_text.dart';
import '../widgets/email_submit_button.dart';
import '../widgets/terms_and_privacy_text.dart';
import '../widgets/marketing_toggle_card.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // 1. Background image crop segment
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.network('https://unsplash.com', fit: BoxFit.cover),
                    Image.asset(
                      'assets/images/login_travel.jfif',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            
              SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GET',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  'YOUR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  'GUIDE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black.withAlpha(120),
                              radius: 20,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.28,
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            
                            AbsorbPointer(
                              absorbing: state is AuthLoading,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SocialLoginButton(
                                    text: 'Continue with Google',
                                    icon: Icons.g_mobiledata,
                                    iconColor: Colors.red,
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                        GoogleSignInRequested(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  SocialLoginButton(
                                    text: 'Continue with Facebook',
                                    icon: Icons.facebook,
                                    iconColor: Colors.blue,
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                        FacebookSignInRequested(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  const DividerWithText(text: 'or'),
                                  const SizedBox(height: 20),

                                  
                                  TextFormField(
                                    controller: _emailController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Email address',
                                      hintStyle: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 15,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF121214),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 18,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.white24,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  EmailSubmitButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                        EmailSignInRequested(
                                          _emailController.text.trim(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            const TermsAndPrivacyText(),
                            const Spacer(),
                            const SizedBox(height: 20),
                            const MarketingToggleCard(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (state is AuthLoading)
                Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
