import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'signup_page.dart';
import 'main_navigation_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = true;
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
    _emailController.dispose();
    _passwordController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (user != null && mounted) {
        // Navigate to main navigation shell so bottom nav is visible
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainNavigationScreen(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e.toString());
        _isLoading = false;
      });
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'No account found with this email';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address';
    } else if (error.contains('user-disabled')) {
      return 'This account has been disabled';
    } else if (error.contains('too-many-requests')) {
      return 'Too many login attempts. Please try again later';
    } else if (error.contains('network')) {
      return 'Network error. Please check your connection';
    }
    return 'Login failed. Please try again';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppTheme.backgroundColor,
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

                    final fadeAnimation =
                        _fadeAnimation ?? const AlwaysStoppedAnimation<double>(1);
                    final slideAnimation = _slideAnimation ??
                        const AlwaysStoppedAnimation<Offset>(Offset.zero);

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
                              child: _buildLoginCard(context),
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

  Widget _buildLoginCard(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor.withOpacity(0.88),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildErrorBanner(),
            if (_errorMessage != null) const SizedBox(height: 16),
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRememberMeToggle(),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Forgot password feature coming soon'),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSignInButton(),
            const SizedBox(height: 24),
            const Divider(height: 32),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Hero(
          tag: 'app_logo_tag',
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.accentColor,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.35),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.currency_exchange,
                    color: Colors.white,
                    size: 36,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Log in to sync your personalized trading insights.',
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

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email address',
        hintText: 'you@example.com',
        prefixIcon: const Icon(Icons.alternate_email_rounded),
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
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
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
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildRememberMeToggle() {
    return InkWell(
      onTap: () {
        setState(() {
          _rememberMe = !_rememberMe;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _rememberMe
                    ? AppTheme.primaryColor
                    : AppTheme.textMutedColor,
              ),
              color: _rememberMe
                  ? AppTheme.primaryColor.withOpacity(0.9)
                  : Colors.transparent,
            ),
            child: _rememberMe
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            'Keep me signed in',
            style: TextStyle(
              color: AppTheme.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
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
                      'Sign In',
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
          "Don't have an account?",
          style: TextStyle(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignupPage(),
                ),
              );
            },
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
              'Create Account',
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
          top: -80,
          right: -40,
          child: _GlowOrb(
            size: 220,
            colors: [
              AppTheme.accentColor.withOpacity(0.5),
              AppTheme.primaryColor.withOpacity(0.2),
            ],
          ),
        ),
        Positioned(
          bottom: -60,
          left: -30,
          child: _GlowOrb(
            size: 180,
            colors: [
              AppTheme.primaryColor.withOpacity(0.45),
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
          radius: 0.8,
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

