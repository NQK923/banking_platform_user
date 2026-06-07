import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validator.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/auth_notifier.dart';
import '../domain/auth_state.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();
  
  bool _obscurePassword = true;
  String _selectedCurrency = 'VND';

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authNotifierProvider.notifier).register(
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
            password: _passwordController.text,
            pin: _pinController.text,
            currency: _selectedCurrency,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);

    final isLoading = authState is AuthStateAuthenticating;
    final errorMessage = authState is AuthStateUnauthenticated ? authState.errorMessage : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký tài khoản'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        message: 'Đang đăng ký...',
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Tạo tài khoản mới',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Text(
                    'Đăng ký thông tin ví điện tử E-Wallet',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  if (errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.m),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(AppRadius.m),
                        border: Border.all(
                          color: theme.colorScheme.error.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: theme.colorScheme.error),
                          const SizedBox(width: AppSpacing.s),
                          Expanded(
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),
                  ],

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: Validator.validateEmail,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: AppSpacing.m),

                  // Phone Field (Optional)
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại (Tùy chọn)',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: Validator.validatePhone,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: AppSpacing.m),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: Validator.validatePassword,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: AppSpacing.m),

                  // 6-digit PIN Field
                  TextFormField(
                    controller: _pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Mã PIN giao dịch (6 chữ số)',
                      prefixIcon: Icon(Icons.password_outlined),
                      counterText: '',
                    ),
                    validator: Validator.validatePin,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: AppSpacing.m),

                  // Currency Selection Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedCurrency,
                    decoration: const InputDecoration(
                      labelText: 'Đơn vị tiền tệ mặc định',
                      prefixIcon: Icon(Icons.payments_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'VND', child: Text('VND (Việt Nam Đồng)')),
                      DropdownMenuItem(value: 'USD', child: Text('USD (Đô la Mỹ)')),
                    ],
                    onChanged: isLoading
                        ? null
                        : (val) {
                            if (val != null) {
                              setState(() {
                                _selectedCurrency = val;
                              });
                            }
                          },
                  ),
                  const SizedBox(height: AppSpacing.l),

                  PrimaryButton(
                    text: 'Đăng Ký',
                    onPressed: _submit,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: AppSpacing.l),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đã có tài khoản? ',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(
                          'Đăng nhập ngay',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
