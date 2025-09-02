# ICS Mobile App - Flutter

🛍️ **ICS (Individual Commerce System)** - Modern e-ticaret ve hizmet rezervasyon mobil uygulaması.

## 📖 Proje Hakkında

ICS App, kullanıcıların ürün satın alabildiği, hizmet rezervasyonu yapabildiği ve randevu alabildiği modern bir Flutter mobil uygulamasıdır. Material 3 tasarım sistemi ile responsive ve kullanıcı dostu bir deneyim sunar.

## ✨ Özellikler

### 🔐 **Kimlik Doğrulama**
- Email/şifre ile giriş
- Güvenli oturum yönetimi
- Şifre göster/gizle özelliği

### 🏠 **Ana Sayfa**
- Bottom navigation ile 5 sekme
- Modern Material 3 tasarım
- Smooth animasyonlar

### 🛒 **Mağaza**
- 7 kategori ile ürün filtreleme
- Yatay kaydırılabilir kategori seçimi
- Grid layout ile ürün listeleme
- İndirim ve stok durumu gösterimi
- Responsive fiyat renklendirmesi

### 🛠️ **Hizmetler**
- Hizmet listesi ve detayları
- Randevu alma sistemi
- Servis süre bilgileri
- WhatsApp entegrasyonu (hazırlık aşamasında)

### 🛍️ **Sepet**
- Ürün adet değiştirme
- Otomatik fiyat hesaplama
- Ücretsiz kargo bilgisi
- Sepeti temizleme özelliği

### 👤 **Profil**
- Kullanıcı bilgileri
- Ayarlar menüsü
- Çıkış yapma

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK (3.2.0+)
- Dart SDK
- iOS: Xcode 14+ (iOS 15.0+)
- Android: Android Studio (API level 21+)

### Adımlar

1. **Projeyi klonlayın**
```bash
git clone <repository-url>
cd ICS-APP-FRONT/flutter_app
```

2. **Dependencies yükleyin**
```bash
flutter pub get
```

3. **Assets klasörlerini kontrol edin**
```bash
# Klasörler otomatik oluşturulmuş olmalı
assets/
├── images/
├── icons/
└── fonts/ (opsiyonel)
```

4. **Uygulamayı çalıştırın**
```bash
# Web tarayıcısında
flutter run -d chrome

# iOS simulatör
flutter run -d ios

# Android emulator
flutter run -d android

# Fiziksel cihaz
flutter devices  # Cihaz ID'sini alın
flutter run -d [DEVICE_ID]
```

## 📁 Proje Yapısı

```
flutter_app/
├── lib/
│   ├── core/                      # Temel sistem dosyaları
│   │   ├── theme/
│   │   │   └── app_theme.dart     # Material 3 tema yapılandırması
│   │   ├── models/                # Data modelleri (gelecek)
│   │   └── network/               # API istemcisi (gelecek)
│   ├── features/                  # Özellik tabanlı klasörleme
│   │   ├── auth/                  # Kimlik doğrulama
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── login_page.dart
│   │   └── home/                  # Ana sayfa ve sekmeler
│   │       └── presentation/
│   │           ├── pages/
│   │           │   └── home_page.dart
│   │           └── widgets/
│   │               ├── home_tab.dart
│   │               ├── services_tab.dart
│   │               ├── catalog_tab.dart
│   │               ├── cart_tab.dart
│   │               └── profile_tab.dart
│   └── main.dart                  # Uygulama giriş noktası
├── assets/                        # Statik dosyalar
│   ├── images/
│   ├── icons/
│   └── fonts/
└── pubspec.yaml                   # Dependencies ve konfigürasyon
```

## 📦 Kullanılan Paketler

### UI & Design
- `flutter` - Flutter framework
- `cupertino_icons` - iOS tarzı ikonlar
- `flutter_svg` - SVG desteği
- `cached_network_image` - Görsel önbellekleme

### State Management
- `flutter_riverpod` - Modern state management

### Navigation
- `go_router` - Deklaratif routing

### Network & API
- `dio` - HTTP istemcisi
- `pretty_dio_logger` - Network log'lama

### Storage
- `flutter_secure_storage` - Güvenli veri saklama
- `shared_preferences` - Basit key-value storage

### Utilities
- `intl` - Uluslararasılaştırma
- `url_launcher` - URL açma
- `image_picker` - Görsel seçimi
- `permission_handler` - İzin yönetimi
- `table_calendar` - Takvim widget'ı
- `webview_flutter` - Web view desteği

### Development
- `flutter_lints` - Kod kalitesi
- `build_runner` - Kod üretimi (gelecek)
- `freezed` - Immutable sınıflar (gelecek)
- `json_serializable` - JSON serialization (gelecek)

## 🎨 Tasarım Sistemi

### Renkler
- **Primary**: `#6750A4` (Material 3 Purple)
- **Success/Normal Price**: `Colors.green[700]`
- **Sale Price**: `Colors.red[600]`
- **Text**: Adaptive (light/dark theme)

### Typography
- **Font Family**: System default (Roboto/SF Pro)
- **Scales**: Material 3 type scale

### Layout
- **Material 3**: Modern cards, buttons, navigation
- **Responsive**: Adaptive grid ve flex layouts
- **Accessibility**: Contrast ratios ve touch targets

## 📱 Platform Desteği

| Platform | Minimum Version | Status |
|----------|----------------|---------|
| iOS      | 15.0+          | ✅ Tested |
| Android  | API 21 (5.0)   | ✅ Ready |
| Web      | Modern browsers | ✅ Tested |
| macOS    | 10.14+         | 🟡 Untested |
| Windows  | Windows 10+    | 🟡 Untested |
| Linux    | Any            | 🟡 Untested |

## ✅ Tamamlanan Özellikler

- [x] **Proje Kurulumu** - Flutter proje yapısı
- [x] **Material 3 Theme** - Modern tasarım sistemi
- [x] **Login Page** - Responsive giriş sayfası
- [x] **Bottom Navigation** - 5 sekme navigasyonu
- [x] **Home Tab** - Karşılama sayfası
- [x] **Services Tab** - Hizmet listesi ve randevu
- [x] **Catalog Tab** - Kategori filtreli ürün mağazası
- [x] **Cart Tab** - Sepet yönetimi ve hesaplama
- [x] **Profile Tab** - Kullanıcı profili
- [x] **Responsive Design** - Tüm ekran boyutları
- [x] **Overflow Fixes** - Layout problemleri çözüldü
- [x] **Color System** - Fiyat ve status renkleri
- [x] **Category Navigation** - Yatay kaydırmalı kategoriler

## 🚧 Devam Eden Geliştirmeler

- [ ] **Firebase Integration** - Authentication & Firestore
- [ ] **API Integration** - Backend bağlantısı
- [ ] **State Management** - Riverpod implementasyonu
- [ ] **Data Models** - JSON serialization
- [ ] **Image Assets** - Ürün ve kategori görselleri
- [ ] **Push Notifications** - Firebase Messaging
- [ ] **Payment Integration** - Iyzico ödeme sistemi
- [ ] **Real Data** - Dinamik içerik

## 🎯 Yakında Eklenecek

### Sprint 2: Authentication & Core (1-2 hafta)
- [ ] Firebase projesi kurulumu
- [ ] Firebase Auth entegrasyonu
- [ ] Token management
- [ ] Protected routes
- [ ] User profile API

### Sprint 3: Katalog & Ürünler (2 hafta)
- [ ] Kategori yönetimi
- [ ] Ürün listesi ve detay sayfası
- [ ] Arama ve filtreleme
- [ ] Favoriler sistemi
- [ ] Ürün görselleri

### Sprint 4: Sepet & Ödeme (2 hafta)
- [ ] Sepet persistency
- [ ] Ödeme sayfası
- [ ] Iyzico entegrasyonu
- [ ] Sipariş takibi
- [ ] Email bildirimleri

### Sprint 5: Hizmetler & Randevu (2 hafta)
- [ ] Hizmet detay sayfaları
- [ ] Takvim entegrasyonu
- [ ] Randevu sistemi
- [ ] WhatsApp entegrasyonu
- [ ] Push notifications

## 🐛 Bilinen Sorunlar

- ~~Overflow hatalar~~ ✅ Çözüldü
- ~~Fiyat renk problemi~~ ✅ Çözüldü
- Firebase henüz entegre edilmedi (demo auth çalışıyor)
- Gerçek API endpoints henüz bağlanmadı

## 🧪 Test

```bash
# Unit testler
flutter test

# Widget testler
flutter test test/widget_test.dart

# Integration testler (gelecek)
flutter drive --target=test_driver/app.dart
```

## 📦 Build

```bash
# Development build
flutter build ios --debug
flutter build android --debug

# Production build
flutter build ios --release
flutter build android --release
flutter build web --release
```

## 🤝 Katkıda Bulunma

1. Feature branch oluşturun
2. Değişikliklerinizi yapın
3. Test edin
4. Pull request gönderin

## 📄 Lisans

Bu proje özel/ticari kullanım içindir.

## 📞 İletişim

- **Geliştirici**: ICS Development Team
- **Email**: dev@ics.com
- **Proje**: ICS Mobile Application

---

**Son Güncelleme**: Aralık 2024
**Versiyon**: 1.0.0+1
**Flutter**: 3.2.0+
**Dart**: 3.2.0+