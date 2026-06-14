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
  String get forgotPasswordQuestion => 'Forgot password?';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get resetPasswordTitle => 'Reset your password';

  @override
  String get resetPasswordSubtitle =>
      'Request an OTP by email, then set a new login password.';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get resettingPassword => 'Resetting password...';

  @override
  String get sendPasswordResetOtp => 'Send email OTP';

  @override
  String get sendingPasswordResetOtp => 'Sending OTP...';

  @override
  String get resendPasswordResetOtp => 'Resend OTP';

  @override
  String get passwordResetOtp => 'Email OTP';

  @override
  String get passwordResetOtpSent =>
      'If the account exists, an OTP has been sent to its registered email.';

  @override
  String get passwordResetSuccess =>
      'Password reset. Sign in with your new password.';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordResetEmailHelp =>
      'Enter the email or phone linked to your wallet. We will send a 6-digit OTP to the registered email.';

  @override
  String get passwordResetOtpHelp =>
      'Enter the 6-digit OTP from your email. It expires soon and can be used once.';

  @override
  String get passwordConfirmationMismatch =>
      'Password confirmation does not match.';

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

  @override
  String get validatorOtp => 'OTP must be exactly 6 digits.';

  @override
  String get continueAction => 'Continue';

  @override
  String get reviewTransfer => 'Review transfer';

  @override
  String get confirmTransfer => 'Confirm transfer';

  @override
  String get sendMoney => 'Send money';

  @override
  String get stepOneOfThree => 'Step 1 of 3';

  @override
  String get stepTwoOfThree => 'Step 2 of 3';

  @override
  String get stepThreeOfThree => 'Step 3 of 3';

  @override
  String get chooseRecipient => 'Choose a recipient';

  @override
  String get chooseRecipientSubtitle =>
      'Use an email address or phone number linked to a wallet.';

  @override
  String get transferPinReminder =>
      'Transfers are sent only after PIN confirmation on the review step.';

  @override
  String get findingRecipient => 'Finding recipient';

  @override
  String get checkingWalletDirectory => 'Checking the wallet directory...';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get transferAmountSubtitle =>
      'Confirm the recipient and choose how much to send.';

  @override
  String get recipient => 'Recipient';

  @override
  String get available => 'Available';

  @override
  String get enterAnAmount => 'Enter an amount.';

  @override
  String get amountGreaterThanZero => 'Amount must be greater than 0.';

  @override
  String get availableBalanceNotEnough => 'Available balance is not enough.';

  @override
  String get messageOptional => 'Message (optional)';

  @override
  String get addShortNote => 'Add a short note';

  @override
  String get reviewAndAuthorize => 'Review and authorize';

  @override
  String get reviewAndAuthorizeSubtitle =>
      'Check details, then confirm with your transaction PIN.';

  @override
  String get amount => 'Amount';

  @override
  String get fee => 'Fee';

  @override
  String get freeFee => 'Free (0 VND)';

  @override
  String get message => 'Message';

  @override
  String get authorizingTransfer => 'Authorizing transfer';

  @override
  String get authorizingTransferMessage =>
      'Keeping your PIN and transfer request secure...';

  @override
  String get inProgress => 'In progress';

  @override
  String get reviewTransferCarefully => 'Review this transfer carefully';

  @override
  String get understandContinue => 'I understand and want to continue';

  @override
  String get confirmWarning => 'Confirm warning';

  @override
  String get confirmWarningMessage =>
      'Enter your transaction PIN to continue with the same transfer request.';

  @override
  String get cancelTransfer => 'Cancel transfer';

  @override
  String get additionalVerificationRequired =>
      'Additional verification required';

  @override
  String get verifyAndContinue => 'Verify and continue';

  @override
  String get verifyTransfer => 'Verify transfer';

  @override
  String get verifyTransferMessage =>
      'Re-enter your transaction PIN for additional verification.';

  @override
  String get transferUnderReview => 'Transfer under review';

  @override
  String get moneyNotDebited => 'Your money has not been debited.';

  @override
  String get reference => 'Reference';

  @override
  String get riskLevel => 'Risk level';

  @override
  String get backToHome => 'Back to home';

  @override
  String get transferBlocked => 'Transfer blocked';

  @override
  String get newTransfer => 'New transfer';

  @override
  String get transferProcessing => 'Transfer processing';

  @override
  String get transferProcessingMessage =>
      'The saga is applying debit and credit entries. Keep this screen open if you want live status.';

  @override
  String get transaction => 'Transaction';

  @override
  String get statusCheck => 'Status check';

  @override
  String get pollingContinues => 'Polling continues on the existing cadence.';

  @override
  String get transferCompleted => 'Transfer completed';

  @override
  String get transferCompletedMessage =>
      'The recipient wallet has been credited.';

  @override
  String get total => 'Total';

  @override
  String get viewTransaction => 'View transaction';

  @override
  String get transferFailed => 'Transfer failed';

  @override
  String get transferFailedRefunded => 'Transfer failed, refunded';

  @override
  String get refundedSenderBalanceRestored =>
      'Refunded: the sender balance was restored after compensation.';

  @override
  String get retryTransfer => 'Retry transfer';

  @override
  String get stillProcessing => 'Still processing';

  @override
  String get stillProcessingMessage =>
      'No final saga result was returned yet. The transaction can still complete in the background.';

  @override
  String get checkAgain => 'Check again';

  @override
  String get goToHistory => 'Go to history';

  @override
  String get retryWithPin => 'Retry with PIN';

  @override
  String get retryWithPinMessage =>
      'Enter your transaction PIN to retry with the same idempotency key.';

  @override
  String get riskSignals => 'Risk signals';

  @override
  String get depositCompleted => 'Deposit completed';

  @override
  String get depositCompletedMessage =>
      'Funds were added to your wallet from the mock CASH_CLEARING account.';

  @override
  String get journal => 'Journal';

  @override
  String get submittingDeposit => 'Submitting deposit...';

  @override
  String get addFunds => 'Add funds';

  @override
  String get addFundsSubtitle =>
      'Mock deposit against the system clearing account.';

  @override
  String get depositAmount => 'Deposit amount';

  @override
  String get depositAmountGreaterThanZero =>
      'Deposit amount must be greater than 0.';

  @override
  String get confirmDeposit => 'Confirm deposit';

  @override
  String get currentBalance => 'Current balance';

  @override
  String get retry => 'Retry';

  @override
  String get confirmWithPin => 'Confirm with PIN';

  @override
  String get withdrawPinMessage =>
      'Enter your 6-digit transaction PIN to authorize this withdrawal.';

  @override
  String get confirm => 'Confirm';

  @override
  String get withdrawalCompleted => 'Withdrawal completed';

  @override
  String get withdrawalCompletedMessage =>
      'Funds were debited from your wallet and moved through the mock clearing flow.';

  @override
  String get submittingWithdrawal => 'Submitting withdrawal...';

  @override
  String get withdrawFunds => 'Withdraw funds';

  @override
  String get withdrawFundsSubtitle =>
      'Move money out through the mock clearing account.';

  @override
  String get withdrawalAmount => 'Withdrawal amount';

  @override
  String get withdrawalAmountGreaterThanZero =>
      'Withdrawal amount must be greater than 0.';

  @override
  String get reviewWithdrawal => 'Review withdrawal';

  @override
  String get validatorPinDigitsOnly => 'PIN can contain digits only.';

  @override
  String get noTransactionHistory => 'No transaction history';

  @override
  String get transactionHistoryEmptyMessage =>
      'Transfers, deposits, and withdrawals will be grouped by date here.';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get transactionTitle => 'Transaction';

  @override
  String get moneySent => 'Money sent';

  @override
  String get moneyReceived => 'Money received';

  @override
  String get failureReason => 'Failure reason';

  @override
  String get askAboutTransaction => 'Ask about this transaction';

  @override
  String get askAboutTransactionSubtitle =>
      'Get a safe explanation of status, refund, failure reason, and traceId.';

  @override
  String get details => 'Details';

  @override
  String get transactionId => 'Transaction ID';

  @override
  String get sender => 'Sender';

  @override
  String get receiver => 'Receiver';

  @override
  String get yourWallet => 'Your wallet';

  @override
  String get created => 'Created';

  @override
  String get updated => 'Updated';

  @override
  String get idempotencyKey => 'Idempotency key';

  @override
  String get correlationId => 'Correlation ID';

  @override
  String get defaultTransferMessage => 'E-Wallet transfer';

  @override
  String copyLabel(String label) {
    return 'Copy $label';
  }

  @override
  String copiedLabel(String label) {
    return '$label copied';
  }

  @override
  String get genericTransferFailureMessage =>
      'The transfer could not be completed. The recipient account may be inactive or the sender balance may no longer be sufficient.';

  @override
  String amountInCurrency(String label, String currency) {
    return '$label in $currency';
  }
}
