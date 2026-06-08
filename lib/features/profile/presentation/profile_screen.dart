import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validator.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../../auth/data/auth_repository.dart';
import '../../transfer/domain/transfer_models.dart';
import '../../wallet/domain/balance_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String _maskPhone(String phone) {
    if (phone.length <= 5) return phone;
    if (phone.startsWith('+')) {
      final start = phone.substring(0, 3);
      final end = phone.substring(phone.length - 3);
      return '$start******$end';
    } else {
      final start = phone.substring(0, 2);
      final end = phone.substring(phone.length - 2);
      return '$start******$end';
    }
  }

  void _showChangePinDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _ChangePinDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final accountState = ref.watch(accountDetailsProvider);
    final theme = Theme.of(context);

    String userId = '';
    if (authState is AuthStateAuthenticated) {
      userId = authState.userId;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cá nhân')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Profile Card
            Center(
              child: accountState.when(
                data: (account) {
                  final code = account.code;
                  final isEmail = code.contains('@');
                  final emailDisplay = isEmail ? code : 'Chưa cập nhật';
                  final phoneDisplay = !isEmail
                      ? _maskPhone(code)
                      : 'Chưa cập nhật';
                  final displayName = isEmail
                      ? code.split('@')[0]
                      : 'Người dùng E-Wallet';

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.1,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.m),
                      Text(
                        displayName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'ID: $userId',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.m),

                      // Email & Phone info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            emailDisplay,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.m),
                          Icon(
                            Icons.phone_outlined,
                            size: 16,
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            phoneDisplay,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: theme.colorScheme.error.withOpacity(0.1),
                      child: Icon(
                        Icons.error_outline,
                        size: 48,
                        color: theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),
                    Text(
                      'Không thể tải thông tin hồ sơ',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextButton.icon(
                      onPressed: () => ref.refresh(accountDetailsProvider),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Options List
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Đổi mã PIN giao dịch'),
                    subtitle: const Text(
                      'Đổi mã PIN bảo mật giao dịch chuyển tiền',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showChangePinDialog(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: const Text('Ngôn ngữ'),
                    subtitle: const Text('Tiếng Việt (vi-VN)'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.logout, color: theme.colorScheme.error),
                    title: Text(
                      'Đăng xuất',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.error,
                    ),
                    onTap: () {
                      ref.read(authNotifierProvider.notifier).logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangePinDialog extends ConsumerStatefulWidget {
  const _ChangePinDialog();

  @override
  ConsumerState<_ChangePinDialog> createState() => _ChangePinDialogState();
}

class _ChangePinDialogState extends ConsumerState<_ChangePinDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await ref
            .read(authRepositoryProvider)
            .changePin(_currentPinController.text, _newPinController.text);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đổi mã PIN giao dịch thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } catch (e) {
        setState(() {
          _errorMessage = e
              .toString()
              .replaceAll('Exception: ', '')
              .replaceAll('AppException: ', '');
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.l),
      ),
      title: const Text(
        'Đổi mã PIN giao dịch',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: _isLoading
          ? const SizedBox(
              height: 120,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: AppSpacing.m),
                    Text('Đang xử lý đổi mã PIN...'),
                  ],
                ),
              ),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.s),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(AppRadius.s),
                          border: Border.all(
                            color: theme.colorScheme.error.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.m),
                    ],
                    TextFormField(
                      controller: _currentPinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Mã PIN hiện tại',
                        counterText: '',
                      ),
                      validator: Validator.validatePin,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    TextFormField(
                      controller: _newPinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Mã PIN mới',
                        counterText: '',
                      ),
                      validator: Validator.validatePin,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    TextFormField(
                      controller: _confirmPinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Xác nhận mã PIN mới',
                        counterText: '',
                      ),
                      validator: (value) {
                        final valErr = Validator.validatePin(value);
                        if (valErr != null) return valErr;
                        if (value != _newPinController.text) {
                          return 'Xác nhận mã PIN không khớp.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
      actions: _isLoading
          ? []
          : [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Lưu thay đổi'),
              ),
            ],
    );
  }
}
