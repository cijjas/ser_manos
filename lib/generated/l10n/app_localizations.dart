import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'SerManos'**
  String get appTitle;

  /// Title for login page
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginPageTitle;

  /// Title for register page
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get registerPageTitle;

  /// Label for begin button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get beginButtonLabel;

  /// Quote displayed on entry page
  ///
  /// In en, this message translates to:
  /// **'\"The selfless effort to bring joy to others will be the beginning of a happier life for ourselves\"'**
  String get entryPageQuote;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcomeMessage;

  /// Welcome page subtitle
  ///
  /// In en, this message translates to:
  /// **'Never underestimate your ability to improve someone\'s life.'**
  String get welcomeSubtitle;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Email field hint text
  ///
  /// In en, this message translates to:
  /// **'e.g. john@mail.com'**
  String get emailHint;

  /// Email field hint text for edit profile
  ///
  /// In en, this message translates to:
  /// **'e.g. myemail@mail.com'**
  String get emailEditHint;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Password field hint text
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get passwordHint;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Name field hint text
  ///
  /// In en, this message translates to:
  /// **'e.g. John'**
  String get nameHint;

  /// Surname field label
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get surname;

  /// Surname field hint text
  ///
  /// In en, this message translates to:
  /// **'e.g. Smith'**
  String get surnameHint;

  /// Phone field hint text
  ///
  /// In en, this message translates to:
  /// **'e.g. +5491178445459'**
  String get phoneHint;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Profile information section title
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInformation;

  /// Contact data section title
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactData;

  /// Personal information section title
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// Profile data section title
  ///
  /// In en, this message translates to:
  /// **'Profile Data'**
  String get profileData;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// Non-binary gender option
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get genderNonBinary;

  /// Error message for gender selection
  ///
  /// In en, this message translates to:
  /// **'Please select your gender.'**
  String get selectGenderError;

  /// Save data button label
  ///
  /// In en, this message translates to:
  /// **'Save Data'**
  String get saveData;

  /// Edit profile button label
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Logout button label
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// Title for logout confirmation modal
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmTitle;

  /// Label for logout button
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutButton;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Profile photo label
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profilePhoto;

  /// Change photo button label
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// Upload photo button label
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get uploadPhoto;

  /// Success message when data is saved
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully'**
  String get dataSavedSuccessfully;

  /// Error message when save fails
  ///
  /// In en, this message translates to:
  /// **'There was an error saving. Try again later.'**
  String get saveErrorMessage;

  /// Error message when loading data fails
  ///
  /// In en, this message translates to:
  /// **'There was an error loading the data. Try again later.'**
  String get loadDataErrorMessage;

  /// Apply button label
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyButton;

  /// Apply button label for tab navigation
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyButtonLabel;

  /// My profile tab label
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// News tab label
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// Search field hint text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// Your activity section title
  ///
  /// In en, this message translates to:
  /// **'Your activity'**
  String get yourActivity;

  /// Volunteering section title
  ///
  /// In en, this message translates to:
  /// **'Volunteering'**
  String get volunteering;

  /// About the activity section title
  ///
  /// In en, this message translates to:
  /// **'About the activity'**
  String get aboutActivity;

  /// Participate in volunteering section title
  ///
  /// In en, this message translates to:
  /// **'Participate in volunteering'**
  String get participateInVolunteering;

  /// Apply to volunteering button label
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyToVolunteering;

  /// You have applied status title
  ///
  /// In en, this message translates to:
  /// **'You have applied'**
  String get youHaveApplied;

  /// Description when user has applied
  ///
  /// In en, this message translates to:
  /// **'You have applied and will enter the candidate list. Meanwhile you can do other volunteering activities'**
  String get youHaveAppliedDescription;

  /// Withdraw application link label
  ///
  /// In en, this message translates to:
  /// **'Withdraw Application'**
  String get withdrawApplication;

  /// You are participating status title
  ///
  /// In en, this message translates to:
  /// **'You Are Participating'**
  String get youAreParticipating;

  /// Description when user is participating
  ///
  /// In en, this message translates to:
  /// **'You are already participating in this activity'**
  String get youAreParticipatingDescription;

  /// Error message when applying fails
  ///
  /// In en, this message translates to:
  /// **'Error applying. Try again.'**
  String get applyError;

  /// Error message when withdrawing application fails
  ///
  /// In en, this message translates to:
  /// **'Error withdrawing application. Try again.'**
  String get withdrawError;

  /// Error message when opening maps fails
  ///
  /// In en, this message translates to:
  /// **'Could not open map. Try again.'**
  String get openMapsError;

  /// Generic unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unknownError;

  /// Unexpected error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred, try again later.'**
  String get unexpectedError;

  /// Share this note section title
  ///
  /// In en, this message translates to:
  /// **'Share This Note'**
  String get shareThisNote;

  /// Error message when loading news fails
  ///
  /// In en, this message translates to:
  /// **'An error occurred loading the news.'**
  String get loadNewsError;

  /// Message when there are no news
  ///
  /// In en, this message translates to:
  /// **'No news yet.'**
  String get noNewsYet;

  /// Vacancies label
  ///
  /// In en, this message translates to:
  /// **'Vacancies'**
  String get vacancies;

  /// Error page title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorPageTitle;

  /// Go back button label
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// Page not found error message
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingMessage;

  /// Date input format hint
  ///
  /// In en, this message translates to:
  /// **'DD/MM/YYYY'**
  String get dateInputHint;

  /// Required field validation error
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredFieldError;

  /// Invalid email validation error
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmailError;

  /// Password too short validation error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShortError;

  /// Invalid phone validation error
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone'**
  String get invalidPhoneError;

  /// Error message when address cannot be retrieved
  ///
  /// In en, this message translates to:
  /// **'Could not get address'**
  String get addressErrorMessage;

  /// Loading state for login button
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No account button label
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get noAccount;

  /// Loading state for register button
  ///
  /// In en, this message translates to:
  /// **'Registering...'**
  String get registering;

  /// Already have account button label
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get alreadyHaveAccount;

  /// Complete button label
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// Take photo option
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// Choose from gallery option
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// Error when image file not found
  ///
  /// In en, this message translates to:
  /// **'The image does not exist on disk.'**
  String get imageNotOnDisk;

  /// User error message
  ///
  /// In en, this message translates to:
  /// **'User error'**
  String get errorUser;

  /// Location label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Address label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Error when loading address fails
  ///
  /// In en, this message translates to:
  /// **'Error loading address. Try again.'**
  String get loadAddressError;

  /// Leave current volunteering action
  ///
  /// In en, this message translates to:
  /// **'Leave current volunteering'**
  String get leaveCurrentVolunteering;

  /// Birth date field label
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Phone field label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Message encouraging profile completion
  ///
  /// In en, this message translates to:
  /// **'Complete your profile to get\naccess to better opportunities!'**
  String get completeProfileMessage;

  /// Error message when abandoning volunteering fails
  ///
  /// In en, this message translates to:
  /// **'Error leaving volunteering. Try again.'**
  String get abandonError;

  /// Section title for participation requirements
  ///
  /// In en, this message translates to:
  /// **'Participate in volunteering'**
  String get participateVolunteering;

  /// Message when user is already participating in another volunteering
  ///
  /// In en, this message translates to:
  /// **'You are already participating in another volunteering, you must leave it first to apply to this one.'**
  String get alreadyParticipating;

  /// Title when user has applied
  ///
  /// In en, this message translates to:
  /// **'You have applied'**
  String get appliedTitle;

  /// Subtitle when user has applied
  ///
  /// In en, this message translates to:
  /// **'Soon the organization will contact you\nand register you as a participant.'**
  String get appliedSubtitle;

  /// Title when user is participating
  ///
  /// In en, this message translates to:
  /// **'You are participating'**
  String get participatingTitle;

  /// Subtitle when user is participating
  ///
  /// In en, this message translates to:
  /// **'The organization confirmed that you are\nalready participating in this volunteering'**
  String get participatingSubtitle;

  /// Leave volunteering action
  ///
  /// In en, this message translates to:
  /// **'Leave volunteering'**
  String get leaveVolunteering;

  /// Message when no vacancies are available
  ///
  /// In en, this message translates to:
  /// **'No vacancies available to apply'**
  String get noVacanciesMessage;

  /// Confirm button label
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Message when user is about to apply
  ///
  /// In en, this message translates to:
  /// **'You are about to apply to'**
  String get postulateActionMessage;

  /// Message when user wants to withdraw application
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to withdraw your application?'**
  String get withdrawActionMessage;

  /// Message when user wants to abandon volunteering
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave your volunteering?'**
  String get abandonActionMessage;

  /// Error message when sharing fails
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred, try again later.'**
  String get shareErrorMessage;

  /// Share button label
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Text before shared URL
  ///
  /// In en, this message translates to:
  /// **'Discover more here:'**
  String get discoverMore;

  /// Label for vacancies count
  ///
  /// In en, this message translates to:
  /// **'Vacancies:'**
  String get vacancies_dot;

  /// Error page title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Message when search returns no volunteering results
  ///
  /// In en, this message translates to:
  /// **'No current volunteering opportunities for your search.'**
  String get noVolunteeringForSearch;

  /// Message when no volunteering opportunities are available
  ///
  /// In en, this message translates to:
  /// **'Currently there are no current volunteering opportunities. New ones will be added soon.'**
  String get noVolunteeringAvailable;

  /// Authentication error prefix
  ///
  /// In en, this message translates to:
  /// **'Auth error:'**
  String get errorAuth;

  /// Volunteer role
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteer;

  /// Read more link on news cards
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// Label for the cost of the volunteer opportunity
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get volunteerCostLabel;

  /// Label for the creation date of the volunteer opportunity
  ///
  /// In en, this message translates to:
  /// **'Created on'**
  String get volunteerCreatedAtLabel;

  /// Message shown when user must complete profile before applying.
  ///
  /// In en, this message translates to:
  /// **'You must complete your profile before applying.'**
  String get completeProfileFirstMessage;

  /// Label for confirm button in dialogs.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmLabel;

  /// Error message when loading user's activity fails.
  ///
  /// In en, this message translates to:
  /// **'Error loading your activity.'**
  String get loadActivityError;

  /// Error message when loading volunteer opportunities fails.
  ///
  /// In en, this message translates to:
  /// **'Error loading volunteer opportunities.'**
  String get loadVolunteeringError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
