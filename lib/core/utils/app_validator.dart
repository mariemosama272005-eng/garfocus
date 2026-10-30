class AppValidator {
  static bool isValidEmail(String email) {
  final RegExp emailRegEx = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  
  return emailRegEx.hasMatch(email);
}
 static bool isPasswordValid(String password) {
  if (password.length < 8) return false;
 // if (!password.contains(RegExp(r'[A-Z]'))) return false;
  //if (!password.contains(RegExp(r'[a-z]'))) return false;
  if (!password.contains(RegExp(r'[0-9]'))) return false;
  //if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
  return true;
}

}