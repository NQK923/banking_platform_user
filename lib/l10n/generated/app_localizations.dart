import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get recentActivity;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsYet;

  /// No description provided for @emptyTransactionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your deposits, withdrawals, and transfers will appear here.'**
  String get emptyTransactionsMessage;

  /// No description provided for @makeDeposit.
  ///
  /// In en, this message translates to:
  /// **'Make a deposit'**
  String get makeDeposit;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get availableBalance;

  /// No description provided for @walletId.
  ///
  /// In en, this message translates to:
  /// **'Wallet ID'**
  String get walletId;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your secure E-Wallet.'**
  String get loginSubtitle;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or phone'**
  String get emailOrPhone;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @noAccountYet.
  ///
  /// In en, this message translates to:
  /// **'No account yet? '**
  String get noAccountYet;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get createOne;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @creatingWallet.
  ///
  /// In en, this message translates to:
  /// **'Creating wallet...'**
  String get creatingWallet;

  /// No description provided for @startSecureWallet.
  ///
  /// In en, this message translates to:
  /// **'Start with a secure wallet'**
  String get startSecureWallet;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your login password and transaction PIN stay separate.'**
  String get registerSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone (optional)'**
  String get phoneOptional;

  /// No description provided for @transactionPin.
  ///
  /// In en, this message translates to:
  /// **'Transaction PIN'**
  String get transactionPin;

  /// No description provided for @defaultCurrency.
  ///
  /// In en, this message translates to:
  /// **'Default currency'**
  String get defaultCurrency;

  /// No description provided for @createWallet.
  ///
  /// In en, this message translates to:
  /// **'Create wallet'**
  String get createWallet;

  /// No description provided for @alreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Already registered? '**
  String get alreadyRegistered;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeTransactionPin.
  ///
  /// In en, this message translates to:
  /// **'Change transaction PIN'**
  String get changeTransactionPin;

  /// No description provided for @changePinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update the 6-digit PIN used for transfers.'**
  String get changePinSubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// No description provided for @contactSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask about transfers, refunds, PIN safety, and account help.'**
  String get contactSupportSubtitle;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'End this secure session.'**
  String get signOutSubtitle;

  /// No description provided for @notAdded.
  ///
  /// In en, this message translates to:
  /// **'Not added'**
  String get notAdded;

  /// No description provided for @ewalletUser.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet user'**
  String get ewalletUser;

  /// No description provided for @pinChanged.
  ///
  /// In en, this message translates to:
  /// **'Transaction PIN changed.'**
  String get pinChanged;

  /// No description provided for @updatingPin.
  ///
  /// In en, this message translates to:
  /// **'Updating PIN...'**
  String get updatingPin;

  /// No description provided for @currentPin.
  ///
  /// In en, this message translates to:
  /// **'Current PIN'**
  String get currentPin;

  /// No description provided for @newPin.
  ///
  /// In en, this message translates to:
  /// **'New PIN'**
  String get newPin;

  /// No description provided for @confirmNewPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm new PIN'**
  String get confirmNewPin;

  /// No description provided for @pinConfirmationMismatch.
  ///
  /// In en, this message translates to:
  /// **'PIN confirmation does not match.'**
  String get pinConfirmationMismatch;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @supportChat.
  ///
  /// In en, this message translates to:
  /// **'Support chat'**
  String get supportChat;

  /// No description provided for @human.
  ///
  /// In en, this message translates to:
  /// **'Human'**
  String get human;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get howCanWeHelp;

  /// No description provided for @supportEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Ask about transfer status, refunds, failed transfers, traceId, PIN safety, recipient lookup, or balance display.'**
  String get supportEmptyMessage;

  /// No description provided for @safetyReminder.
  ///
  /// In en, this message translates to:
  /// **'Never share PIN, password, OTP, or tokens.'**
  String get safetyReminder;

  /// No description provided for @transactionShort.
  ///
  /// In en, this message translates to:
  /// **'Transaction {id}'**
  String transactionShort(String id);

  /// No description provided for @assistant.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get assistant;

  /// No description provided for @systemSender.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemSender;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @askSupport.
  ///
  /// In en, this message translates to:
  /// **'Ask support...'**
  String get askSupport;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendMessage;

  /// No description provided for @validatorRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validatorRequired;

  /// No description provided for @validatorEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get validatorEmail;

  /// No description provided for @validatorPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number.'**
  String get validatorPhone;

  /// No description provided for @validatorIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Enter an email or phone number.'**
  String get validatorIdentifier;

  /// No description provided for @validatorPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get validatorPassword;

  /// No description provided for @validatorPin.
  ///
  /// In en, this message translates to:
  /// **'PIN must be exactly 6 digits.'**
  String get validatorPin;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @reviewTransfer.
  ///
  /// In en, this message translates to:
  /// **'Review transfer'**
  String get reviewTransfer;

  /// No description provided for @confirmTransfer.
  ///
  /// In en, this message translates to:
  /// **'Confirm transfer'**
  String get confirmTransfer;

  /// No description provided for @sendMoney.
  ///
  /// In en, this message translates to:
  /// **'Send money'**
  String get sendMoney;

  /// No description provided for @stepOneOfThree.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3'**
  String get stepOneOfThree;

  /// No description provided for @stepTwoOfThree.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3'**
  String get stepTwoOfThree;

  /// No description provided for @stepThreeOfThree.
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3'**
  String get stepThreeOfThree;

  /// No description provided for @chooseRecipient.
  ///
  /// In en, this message translates to:
  /// **'Choose a recipient'**
  String get chooseRecipient;

  /// No description provided for @chooseRecipientSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use an email address or phone number linked to a wallet.'**
  String get chooseRecipientSubtitle;

  /// No description provided for @transferPinReminder.
  ///
  /// In en, this message translates to:
  /// **'Transfers are sent only after PIN confirmation on the review step.'**
  String get transferPinReminder;

  /// No description provided for @findingRecipient.
  ///
  /// In en, this message translates to:
  /// **'Finding recipient'**
  String get findingRecipient;

  /// No description provided for @checkingWalletDirectory.
  ///
  /// In en, this message translates to:
  /// **'Checking the wallet directory...'**
  String get checkingWalletDirectory;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @transferAmountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm the recipient and choose how much to send.'**
  String get transferAmountSubtitle;

  /// No description provided for @recipient.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get recipient;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @enterAnAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount.'**
  String get enterAnAmount;

  /// No description provided for @amountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 0.'**
  String get amountGreaterThanZero;

  /// No description provided for @availableBalanceNotEnough.
  ///
  /// In en, this message translates to:
  /// **'Available balance is not enough.'**
  String get availableBalanceNotEnough;

  /// No description provided for @messageOptional.
  ///
  /// In en, this message translates to:
  /// **'Message (optional)'**
  String get messageOptional;

  /// No description provided for @addShortNote.
  ///
  /// In en, this message translates to:
  /// **'Add a short note'**
  String get addShortNote;

  /// No description provided for @reviewAndAuthorize.
  ///
  /// In en, this message translates to:
  /// **'Review and authorize'**
  String get reviewAndAuthorize;

  /// No description provided for @reviewAndAuthorizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check details, then confirm with your transaction PIN.'**
  String get reviewAndAuthorizeSubtitle;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @freeFee.
  ///
  /// In en, this message translates to:
  /// **'Free (0 VND)'**
  String get freeFee;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @authorizingTransfer.
  ///
  /// In en, this message translates to:
  /// **'Authorizing transfer'**
  String get authorizingTransfer;

  /// No description provided for @authorizingTransferMessage.
  ///
  /// In en, this message translates to:
  /// **'Keeping your PIN and transfer request secure...'**
  String get authorizingTransferMessage;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @reviewTransferCarefully.
  ///
  /// In en, this message translates to:
  /// **'Review this transfer carefully'**
  String get reviewTransferCarefully;

  /// No description provided for @understandContinue.
  ///
  /// In en, this message translates to:
  /// **'I understand and want to continue'**
  String get understandContinue;

  /// No description provided for @confirmWarning.
  ///
  /// In en, this message translates to:
  /// **'Confirm warning'**
  String get confirmWarning;

  /// No description provided for @confirmWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your transaction PIN to continue with the same transfer request.'**
  String get confirmWarningMessage;

  /// No description provided for @cancelTransfer.
  ///
  /// In en, this message translates to:
  /// **'Cancel transfer'**
  String get cancelTransfer;

  /// No description provided for @additionalVerificationRequired.
  ///
  /// In en, this message translates to:
  /// **'Additional verification required'**
  String get additionalVerificationRequired;

  /// No description provided for @verifyAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify and continue'**
  String get verifyAndContinue;

  /// No description provided for @verifyTransfer.
  ///
  /// In en, this message translates to:
  /// **'Verify transfer'**
  String get verifyTransfer;

  /// No description provided for @verifyTransferMessage.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your transaction PIN for additional verification.'**
  String get verifyTransferMessage;

  /// No description provided for @transferUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Transfer under review'**
  String get transferUnderReview;

  /// No description provided for @moneyNotDebited.
  ///
  /// In en, this message translates to:
  /// **'Your money has not been debited.'**
  String get moneyNotDebited;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @riskLevel.
  ///
  /// In en, this message translates to:
  /// **'Risk level'**
  String get riskLevel;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @transferBlocked.
  ///
  /// In en, this message translates to:
  /// **'Transfer blocked'**
  String get transferBlocked;

  /// No description provided for @newTransfer.
  ///
  /// In en, this message translates to:
  /// **'New transfer'**
  String get newTransfer;

  /// No description provided for @transferProcessing.
  ///
  /// In en, this message translates to:
  /// **'Transfer processing'**
  String get transferProcessing;

  /// No description provided for @transferProcessingMessage.
  ///
  /// In en, this message translates to:
  /// **'The saga is applying debit and credit entries. Keep this screen open if you want live status.'**
  String get transferProcessingMessage;

  /// No description provided for @transaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transaction;

  /// No description provided for @statusCheck.
  ///
  /// In en, this message translates to:
  /// **'Status check'**
  String get statusCheck;

  /// No description provided for @pollingContinues.
  ///
  /// In en, this message translates to:
  /// **'Polling continues on the existing cadence.'**
  String get pollingContinues;

  /// No description provided for @transferCompleted.
  ///
  /// In en, this message translates to:
  /// **'Transfer completed'**
  String get transferCompleted;

  /// No description provided for @transferCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'The recipient wallet has been credited.'**
  String get transferCompletedMessage;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @viewTransaction.
  ///
  /// In en, this message translates to:
  /// **'View transaction'**
  String get viewTransaction;

  /// No description provided for @transferFailed.
  ///
  /// In en, this message translates to:
  /// **'Transfer failed'**
  String get transferFailed;

  /// No description provided for @transferFailedRefunded.
  ///
  /// In en, this message translates to:
  /// **'Transfer failed, refunded'**
  String get transferFailedRefunded;

  /// No description provided for @refundedSenderBalanceRestored.
  ///
  /// In en, this message translates to:
  /// **'Refunded: the sender balance was restored after compensation.'**
  String get refundedSenderBalanceRestored;

  /// No description provided for @retryTransfer.
  ///
  /// In en, this message translates to:
  /// **'Retry transfer'**
  String get retryTransfer;

  /// No description provided for @stillProcessing.
  ///
  /// In en, this message translates to:
  /// **'Still processing'**
  String get stillProcessing;

  /// No description provided for @stillProcessingMessage.
  ///
  /// In en, this message translates to:
  /// **'No final saga result was returned yet. The transaction can still complete in the background.'**
  String get stillProcessingMessage;

  /// No description provided for @checkAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get checkAgain;

  /// No description provided for @goToHistory.
  ///
  /// In en, this message translates to:
  /// **'Go to history'**
  String get goToHistory;

  /// No description provided for @retryWithPin.
  ///
  /// In en, this message translates to:
  /// **'Retry with PIN'**
  String get retryWithPin;

  /// No description provided for @retryWithPinMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your transaction PIN to retry with the same idempotency key.'**
  String get retryWithPinMessage;

  /// No description provided for @riskSignals.
  ///
  /// In en, this message translates to:
  /// **'Risk signals'**
  String get riskSignals;

  /// No description provided for @depositCompleted.
  ///
  /// In en, this message translates to:
  /// **'Deposit completed'**
  String get depositCompleted;

  /// No description provided for @depositCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Funds were added to your wallet from the mock CASH_CLEARING account.'**
  String get depositCompletedMessage;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @submittingDeposit.
  ///
  /// In en, this message translates to:
  /// **'Submitting deposit...'**
  String get submittingDeposit;

  /// No description provided for @addFunds.
  ///
  /// In en, this message translates to:
  /// **'Add funds'**
  String get addFunds;

  /// No description provided for @addFundsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mock deposit against the system clearing account.'**
  String get addFundsSubtitle;

  /// No description provided for @depositAmount.
  ///
  /// In en, this message translates to:
  /// **'Deposit amount'**
  String get depositAmount;

  /// No description provided for @depositAmountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Deposit amount must be greater than 0.'**
  String get depositAmountGreaterThanZero;

  /// No description provided for @confirmDeposit.
  ///
  /// In en, this message translates to:
  /// **'Confirm deposit'**
  String get confirmDeposit;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentBalance;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @confirmWithPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm with PIN'**
  String get confirmWithPin;

  /// No description provided for @withdrawPinMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your 6-digit transaction PIN to authorize this withdrawal.'**
  String get withdrawPinMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @withdrawalCompleted.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal completed'**
  String get withdrawalCompleted;

  /// No description provided for @withdrawalCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Funds were debited from your wallet and moved through the mock clearing flow.'**
  String get withdrawalCompletedMessage;

  /// No description provided for @submittingWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Submitting withdrawal...'**
  String get submittingWithdrawal;

  /// No description provided for @withdrawFunds.
  ///
  /// In en, this message translates to:
  /// **'Withdraw funds'**
  String get withdrawFunds;

  /// No description provided for @withdrawFundsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Move money out through the mock clearing account.'**
  String get withdrawFundsSubtitle;

  /// No description provided for @withdrawalAmount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal amount'**
  String get withdrawalAmount;

  /// No description provided for @withdrawalAmountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal amount must be greater than 0.'**
  String get withdrawalAmountGreaterThanZero;

  /// No description provided for @reviewWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Review withdrawal'**
  String get reviewWithdrawal;

  /// No description provided for @validatorPinDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'PIN can contain digits only.'**
  String get validatorPinDigitsOnly;

  /// No description provided for @noTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'No transaction history'**
  String get noTransactionHistory;

  /// No description provided for @transactionHistoryEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Transfers, deposits, and withdrawals will be grouped by date here.'**
  String get transactionHistoryEmptyMessage;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @transactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionTitle;

  /// No description provided for @moneySent.
  ///
  /// In en, this message translates to:
  /// **'Money sent'**
  String get moneySent;

  /// No description provided for @moneyReceived.
  ///
  /// In en, this message translates to:
  /// **'Money received'**
  String get moneyReceived;

  /// No description provided for @failureReason.
  ///
  /// In en, this message translates to:
  /// **'Failure reason'**
  String get failureReason;

  /// No description provided for @askAboutTransaction.
  ///
  /// In en, this message translates to:
  /// **'Ask about this transaction'**
  String get askAboutTransaction;

  /// No description provided for @askAboutTransactionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get a safe explanation of status, refund, failure reason, and traceId.'**
  String get askAboutTransactionSubtitle;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @sender.
  ///
  /// In en, this message translates to:
  /// **'Sender'**
  String get sender;

  /// No description provided for @receiver.
  ///
  /// In en, this message translates to:
  /// **'Receiver'**
  String get receiver;

  /// No description provided for @yourWallet.
  ///
  /// In en, this message translates to:
  /// **'Your wallet'**
  String get yourWallet;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updated;

  /// No description provided for @idempotencyKey.
  ///
  /// In en, this message translates to:
  /// **'Idempotency key'**
  String get idempotencyKey;

  /// No description provided for @correlationId.
  ///
  /// In en, this message translates to:
  /// **'Correlation ID'**
  String get correlationId;

  /// No description provided for @defaultTransferMessage.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet transfer'**
  String get defaultTransferMessage;

  /// No description provided for @copyLabel.
  ///
  /// In en, this message translates to:
  /// **'Copy {label}'**
  String copyLabel(String label);

  /// No description provided for @copiedLabel.
  ///
  /// In en, this message translates to:
  /// **'{label} copied'**
  String copiedLabel(String label);

  /// No description provided for @genericTransferFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'The transfer could not be completed. The recipient account may be inactive or the sender balance may no longer be sufficient.'**
  String get genericTransferFailureMessage;

  /// No description provided for @amountInCurrency.
  ///
  /// In en, this message translates to:
  /// **'{label} in {currency}'**
  String amountInCurrency(String label, String currency);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
