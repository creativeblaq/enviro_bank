final List<String> bankOptions = [
  'ABSA',
  'CAPITEC',
  'FNB',
  'INVESTEC LIMITED',
  'NEDBANK LIMITED',
  'STANDARD BANK',
  'VBS'
];

class Strings {
  static const String BgImage = "assets/images/enviro_bg.png";
  //Generic Strings
  static const String appName = "Enviro Bank";
  static const String signIn = "Sign In";
  static const String signUp = "Sign Up";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String createNewAccount = "Don't have an account? ";
  static const String or = "Or";
  static const String cancel = "Cancel";
  static const String back = "Back";
  static const String deleteAccount = "Delete Account";
  static const String logout = "Logout";
  static const String ok = "Okay";
  static const String done = "Done";
  static const String save = 'Save';
  static const String cont = "Continue";
  static const String submit = "Submit";
  static const String forgotPass = 'Forgot password?';
  static const String resetPass = 'Reset password';
  static const String pleaseWait = 'Please wait...';

  //Form fields
  static const String idNumberField = 'Id Number';
  static const String dobField = "Date of birth";
  static const String nameField = 'First name';
  static const String surnameField = 'Last name';
  static const String contactField = 'Contact';
  static const String collectionDateField = 'Collection date (debit order)';
  static const String accountNumberField = 'Account number';
  static const String branchCodeField = 'Branch code';
  static const String bankNameField = 'Bank name';
  static const String confirmPasswordField = 'Confirm password';
  static const String emailField = 'Email';
  static const String passwordField = 'Password';
  static const String loanAmountField = 'Loan amount';

  //Form gender constants
  static const String genderMale = 'Male';
  static const String genderFemale = 'Female';
  static const String genderOther = 'Other';
  static const String genderOtherHint = 'Specify Gender';

  //Form Validators
  static const String namePattern = r'^[a-z A-Z,.\-]+$';
  static const String contactPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static const String passwordPattern =
      r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";

  static const String mustMatch = 'mustMatch';

  //Form style text
  static const String nameHint = 'John';
  static const String surnameHint = 'Doe';
  static const String contactHint = '0830004000';
  static const String emailHint = 'john@gmail.com';
  static const String dobHint = '1997/01/01';
  static const String collectionDayHint = '2022/01/15';

  //Form Error Messages
  static const String errorRequired = 'Field can\'t be empty';
  static const String errorInvalidName = 'Please enter a valid name.';
  static const String errorInvalidSurname = 'Please enter a valid surname.';
  static const String errorInvalidContact = 'Please enter a valid SA contact.';
  static const String errorInvalidEmail = 'Please enter a valid email.';
  static const String errorPassword =
      'Password must be 8 characters and contain uppercase letter, '
      'one digit and one special character';
  static const String errorPasswordMatch = 'Passwords don\'t match';

  //Home page
  static const String introMessage =
      "We’ve made applying for loans quick and simple. Click on apply below and get that loan today!";
  static const String startApplicationMessage =
      "Let's get started. We’re going to need a couple of details before we continue. "
      "Please fill in the form below to apply.";
}
