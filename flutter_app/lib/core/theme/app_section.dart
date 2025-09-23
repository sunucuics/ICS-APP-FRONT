/// App sections for theme accent management
enum AppSection {
  home,
  services,
  store,
  cart,
  profile,
}

/// Extension to get section display names
extension AppSectionExtension on AppSection {
  String get displayName {
    switch (this) {
      case AppSection.home:
        return 'Ana Sayfa';
      case AppSection.services:
        return 'Hizmetler';
      case AppSection.store:
        return 'Mağaza';
      case AppSection.cart:
        return 'Sepet';
      case AppSection.profile:
        return 'Profil';
    }
  }

  String get iconName {
    switch (this) {
      case AppSection.home:
        return 'home';
      case AppSection.services:
        return 'business';
      case AppSection.store:
        return 'store';
      case AppSection.cart:
        return 'shopping_cart';
      case AppSection.profile:
        return 'person';
    }
  }
}
