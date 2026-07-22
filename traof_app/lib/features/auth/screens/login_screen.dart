import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/constants/app_constants.dart';

enum UserRole { donor, family, employee, admin }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  bool _obscurePassword = true;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole? _selectedRole;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildRoleSelector(),
                  const SizedBox(height: 24),
                  _buildLoginForm(),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                  const SizedBox(height: 16),
                  _buildForgotPassword(),
                  const SizedBox(height: 24),
                  _buildOTPButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.volunteer_activism,
            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'تراؤف',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSelector() {
    final roles = [
      {'role': UserRole.donor, 'icon': Icons.favorite, 'label': 'داعم', 'color': AppColors.donationGold},
      {'role': UserRole.family, 'icon': Icons.family_restroom, 'label': 'أسرة', 'color': AppColors.familyBlue},
      {'role': UserRole.employee, 'icon': Icons.person, 'label': 'موظف', 'color': AppColors.employeeGreen},
      {'role': UserRole.admin, 'icon': Icons.admin_panel_settings, 'label': 'مدير', 'color': AppColors.adminPurple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'اختر نوع الحساب',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: roles.map((r) {
            final isSelected = _selectedRole == r['role'];
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedRole = r['role'] as UserRole),
                child: AnimatedContainer(
                  duration: AppConstants.animationDuration,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (r['color'] as Color)
                        : Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.3),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        r['icon'] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        r['label'] as String,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextField(
            label: 'رقم الجوال',
            hint: '05XXXXXXXX',
            prefixIcon: Icons.phone_android,
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل رقم الجوال';
              }
              if (value.length != AppConstants.phoneLength) {
                return 'رقم الجوال يجب أن يكون ${AppConstants.phoneLength} أرقام';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'كلمة المرور',
            prefixIcon: Icons.lock_outline,
            suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
            onSuffixTap: () => setState(() => _obscurePassword = !_obscurePassword),
            obscureText: _obscurePassword,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'أدخل كلمة المرور';
              }
              if (value.length < 6) {
                return 'كلمة المرور 6 أحرف على الأقل';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: 'تسجيل الدخول',
      icon: Icons.login,
      onPressed: () {
        if (_selectedRole == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('اختر نوع الحساب أولاً', style: TextStyle(fontFamily: 'Cairo'))),
          );
          return;
        }
        _navigateToRole();
      },
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'نسيت كلمة المرور؟',
        style: TextStyle(
          fontFamily: 'Cairo',
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildOTPButton() {
    return CustomButton(
      text: 'الدخول بـ OTP',
      icon: Icons.sms,
      isOutlined: true,
      color: Colors.white,
      onPressed: () {
        if (_selectedRole == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('اختر نوع الحساب أولاً', style: TextStyle(fontFamily: 'Cairo'))),
          );
          return;
        }
        _showOTPDialog();
      },
    );
  }

  void _navigateToRole() {
    switch (_selectedRole!) {
      case UserRole.donor:
        Navigator.pushReplacementNamed(context, '/donor');
        break;
      case UserRole.family:
        Navigator.pushReplacementNamed(context, '/family');
        break;
      case UserRole.employee:
        Navigator.pushReplacementNamed(context, '/employee');
        break;
      case UserRole.admin:
        Navigator.pushReplacementNamed(context, '/admin');
        break;
    }
  }

  void _showOTPDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'التحقق بـ OTP',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'أدخل رقم الجوال لإرسال كود التحقق',
              style: TextStyle(fontFamily: 'Cairo', color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'رقم الجوال',
              prefixIcon: Icons.phone_android,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showOTPVerifyDialog();
            },
            child: const Text('إرسال', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  void _showOTPVerifyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'أدخل كود التحقق',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'تم إرسال كود مكون من 6 أرقام',
              style: TextStyle(fontFamily: 'Cairo', color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                AppConstants.otpLength,
                (index) => Container(
                  width: 45,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.divider),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToRole();
            },
            child: const Text('تحقق', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}
