// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'E-Wallet';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get support => 'Support';

  @override
  String get profile => 'Profile';

  @override
  String get wallet => 'Wallet';

  @override
  String get refresh => 'Refresh';

  @override
  String get send => 'Send';

  @override
  String get deposit => 'Deposit';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get recentActivity => 'Recent activity';

  @override
  String get viewAll => 'View all';

  @override
  String get noTransactionsYet => 'No transactions yet';

  @override
  String get emptyTransactionsMessage =>
      'Your deposits, withdrawals, and transfers will appear here.';

  @override
  String get makeDeposit => 'Make a deposit';

  @override
  String get availableBalance => 'Available balance';

  @override
  String get walletId => 'Wallet ID';

  @override
  String get signingIn => 'Signing in...';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get loginSubtitle => 'Sign in to your secure E-Wallet.';

  @override
  String get emailOrPhone => 'Email or phone';

  @override
  String get password => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signIn => 'Sign in';

  @override
  String get noAccountYet => 'No account yet? ';

  @override
  String get createOne => 'Create one';

  @override
  String get createAccount => 'Create account';

  @override
  String get back => 'Back';

  @override
  String get creatingWallet => 'Creating wallet...';

  @override
  String get startSecureWallet => 'Start with a secure wallet';

  @override
  String get registerSubtitle =>
      'Your login password and transaction PIN stay separate.';

  @override
  String get email => 'Email';

  @override
  String get phoneOptional => 'Phone (optional)';

  @override
  String get transactionPin => 'Transaction PIN';

  @override
  String get defaultCurrency => 'Default currency';

  @override
  String get createWallet => 'Create wallet';

  @override
  String get alreadyRegistered => 'Already registered? ';

  @override
  String get settings => 'Settings';

  @override
  String get changeTransactionPin => 'Change transaction PIN';

  @override
  String get changePinSubtitle => 'Update the 6-digit PIN used for transfers.';

  @override
  String get appearance => 'Appearance';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get contactSupport => 'Contact support';

  @override
  String get contactSupportSubtitle =>
      'Ask about transfers, refunds, PIN safety, and account help.';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutSubtitle => 'End this secure session.';

  @override
  String get notAdded => 'Not added';

  @override
  String get ewalletUser => 'E-Wallet user';

  @override
  String get pinChanged => 'Transaction PIN changed.';

  @override
  String get updatingPin => 'Updating PIN...';

  @override
  String get currentPin => 'Current PIN';

  @override
  String get newPin => 'New PIN';

  @override
  String get confirmNewPin => 'Confirm new PIN';

  @override
  String get pinConfirmationMismatch => 'PIN confirmation does not match.';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get supportChat => 'Support chat';

  @override
  String get human => 'Human';

  @override
  String get howCanWeHelp => 'How can we help?';

  @override
  String get supportEmptyMessage =>
      'Ask about transfer status, refunds, failed transfers, traceId, PIN safety, recipient lookup, or balance display.';

  @override
  String get safetyReminder => 'Never share PIN, password, OTP, or tokens.';

  @override
  String transactionShort(String id) {
    return 'Transaction $id';
  }

  @override
  String get assistant => 'Assistant';

  @override
  String get systemSender => 'System';

  @override
  String get you => 'You';

  @override
  String get askSupport => 'Ask support...';

  @override
  String get sendMessage => 'Send';

  @override
  String get validatorRequired => 'This field is required.';

  @override
  String get validatorEmail => 'Enter a valid email address.';

  @override
  String get validatorPhone => 'Enter a valid phone number.';

  @override
  String get validatorIdentifier => 'Enter an email or phone number.';

  @override
  String get validatorPassword => 'Password must be at least 6 characters.';

  @override
  String get validatorPin => 'PIN must be exactly 6 digits.';
}
