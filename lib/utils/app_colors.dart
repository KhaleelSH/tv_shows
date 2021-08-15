// class AppColors {
//   static const int primaryColor = 0xFFFF758C;
// }
//

// I did it like this just for showing some enumerators and call() usages,
// Usually, I would do it something like the code block commented at the top.
enum AppColors {
  primaryColor,
  primaryBlack,
  darkGrey,
  lightGrey,
  lighterGrey,
  mystic,
}

// The call() method allows us to call methods on objects
// as if the object itself is a method, ex: AppColors.darkGrey().
extension AppColorsExtension on AppColors {
  int call() {
    switch (this) {
      case AppColors.primaryColor:
        return 0xFFFF758C;
      case AppColors.primaryBlack:
        return 0xFF2E2E2E;
      case AppColors.darkGrey:
        return 0xFF505050;
      case AppColors.lightGrey:
        return 0xFFA0A0A0;
      case AppColors.lighterGrey:
        return 0xFFEDEDED;
      case AppColors.mystic:
        return 0xFFEEF1F5;
    }
  }
}
