/// Password should have,
/// at least a upper case letter
///  at least a lower case letter
///  at least a digit
///  at least a special character [@#$%^&+=]
///  length of at least 4
/// no white space allowed
bool isValidPassword(String? inputString, {bool isRequired = false}) { 
bool isInputStringValid = false;

if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {

isInputStringValid = true;

}

if (inputString != null) {

const pattern = r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';

final regExp = RegExp(pattern);

isInputStringValid = regExp.hasMatch(inputString) ;

}

return isInputStringValid; } /// Checks if string consist only Alphabet. (No Whitespace)
bool isText(String? inputString, {bool isRequired = false}) { 
bool isInputStringValid = false;

if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {

isInputStringValid = true;

}

if (inputString != null) {

const pattern = r'^[a-zA-Z]+$';

final regExp = RegExp(pattern);

isInputStringValid = regExp.hasMatch(inputString) ;

}

return isInputStringValid; } 