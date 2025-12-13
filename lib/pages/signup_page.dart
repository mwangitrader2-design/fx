import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'main_navigation_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  String? _errorMessage;

  AnimationController? _controller;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreeToTerms) {
      setState(() {
        _errorMessage = 'Please accept the terms to continue.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _fullNameController.text.trim(),
      );

      if (user != null && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account created successfully!'),
            backgroundColor: AppTheme.successColor,
          ),
        );

        // Navigate to main navigation shell so bottom nav is visible
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainNavigationScreen(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fadeAnimation =
        _fadeAnimation ?? const AlwaysStoppedAnimation<double>(1);
    final slideAnimation =
        _slideAnimation ?? const AlwaysStoppedAnimation<Offset>(Offset.zero);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            _buildBackgroundDecor(),
            SafeArea(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth > 560
                        ? 520.0
                        : constraints.maxWidth - 32;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: FadeTransition(
                            opacity: fadeAnimation,
                            child: SlideTransition(
                              position: slideAnimation,
                              child: _buildSignupCard(context),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupCard(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 30,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Text(
              'Set up your secure account and sync across your trading devices.',
              style: TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildErrorBanner(),
            if (_errorMessage != null) const SizedBox(height: 16),
            _buildFullNameField(),
            const SizedBox(height: 16),
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 16),
            _buildConfirmPasswordField(),
            const SizedBox(height: 18),
            _buildTermsRow(),
            const SizedBox(height: 24),
            _buildSignupButton(),
            const SizedBox(height: 24),
            const Divider(height: 32),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: 'app_logo_tag',
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.accentColor,
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.currency_exchange,
                    color: Colors.white,
                    size: 32,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create account',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Join the AI-powered trading suite in seconds.',
                style: TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBanner() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _errorMessage == null
          ? const SizedBox.shrink()
          : Container(
              key: ValueKey(_errorMessage),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.16),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.errorColor.withOpacity(0.35),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: AppTheme.errorColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      controller: _fullNameController,
      keyboardType: TextInputType.name,
      decoration: _fieldDecoration(
        label: 'Full name',
        hint: 'Enter your full name',
        icon: Icons.person_outline,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        if (value.length < 3) {
          return 'Name must be at least 3 characters';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _fieldDecoration(
        label: 'Email address',
        hint: 'you@example.com',
        icon: Icons.email_outlined,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: _fieldDecoration(
        label: 'Password',
        hint: 'Create a strong password',
        icon: Icons.lock_outline,
        suffix: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      decoration: _fieldDecoration(
        label: 'Confirm password',
        hint: 'Re-enter your password',
        icon: Icons.lock_outline,
        suffix: IconButton(
          icon: Icon(
            _obscureConfirmPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildTermsRow() {
    return InkWell(
      onTap: () {
        setState(() {
          _agreeToTerms = !_agreeToTerms;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _agreeToTerms
                    ? AppTheme.primaryColor
                    : AppTheme.textMutedColor,
              ),
              color: _agreeToTerms
                  ? AppTheme.primaryColor.withOpacity(0.95)
                  : Colors.transparent,
            ),
            child: _agreeToTerms
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(color: AppTheme.primaryColor),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: AppTheme.primaryColor),
                  ),
                  const TextSpan(text: '.'),
                ],
                style: TextStyle(
                  color: AppTheme.textSecondaryColor,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignup,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor,
                AppTheme.accentColor,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _isLoading
                  ? const SizedBox(
                      key: ValueKey('loader'),
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Text(
                      'Create Account',
                      key: ValueKey('label'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppTheme.primaryColor.withOpacity(0.6),
                width: 1.4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Back to Sign In',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundDecor() {
    return Stack(
      children: [
        Positioned(
          top: -60,
          left: -30,
          child: _GlowOrb(
            size: 200,
            colors: [
              AppTheme.primaryColor.withOpacity(0.45),
              AppTheme.accentColor.withOpacity(0.2),
            ],
          ),
        ),
        Positioned(
          bottom: -80,
          right: -40,
          child: _GlowOrb(
            size: 240,
            colors: [
              AppTheme.accentColor.withOpacity(0.4),
              Colors.black,
            ],
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.colors,
  });

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: colors,
          radius: 0.85,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.35),
            blurRadius: 60,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
