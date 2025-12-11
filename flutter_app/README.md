# ICS Mobile App - Flutter

**ICS (Individual Commerce System)** - Modern e-ticaret ve hizmet rezervasyon mobil uygulaması.

## Proje Hakkında

ICS App, kullanıcıların ürün satın alabildiği, hizmet rezervasyonu yapabildiği ve randevu alabildiği modern bir Flutter mobil uygulamasıdır. Material 3 tasarım sistemi ile responsive ve kullanıcı dostu bir deneyim sunar.

## Özellikler

### Kimlik Doğrulama
- Email/şifre ile giriş ve kayıt
- Misafir kullanıcı desteği (anonymous authentication)
- Güvenli oturum yönetimi
- Guest to registered user upgrade

### Ana Özellikler
- **Ana Sayfa**: Kullanıcı karşılama, hızlı erişim butonları, öne çıkan içerikler
- **Mağaza**: Kategori filtreli ürün kataloğu, arama, ürün detayları
- **Hizmetler**: Hizmet listesi, randevu alma sistemi
- **Sepet**: Ürün yönetimi, otomatik fiyat hesaplama
- **Profil**: Kullanıcı bilgileri, siparişler, adresler, randevular, ayarlar

### Sipariş Yönetimi
- Sipariş oluşturma ve takibi
- Adres yönetimi
- Ödeme entegrasyonu (PayTR)
- Sipariş durumu güncellemeleri

### Backend Entegrasyonu
- RESTful API ile tam entegrasyon
- Real-time veri senkronizasyonu
- Hata yönetimi ve kullanıcı geri bildirimi

## Kurulum

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

3. **Code generation çalıştırın**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. **Uygulamayı çalıştırın**
```bash
# Web tarayıcısında
flutter run -d chrome

# iOS simulatör
flutter run -d ios

# Android emulator
flutter run -d android
```

## Proje Yapısı

```
flutter_app/
├── lib/
│   ├── core/                      # Temel sistem dosyaları
│   │   ├── models/                # Data modelleri
│   │   ├── network/               # API istemcisi
│   │   ├── services/              # Servisler
│   │   ├── theme/                 # Tema yapılandırması
│   │   ├── utils/                 # Yardımcı fonksiyonlar
│   │   └── widgets/               # Ortak widget'lar
│   ├── features/                  # Özellik tabanlı klasörleme
│   │   ├── auth/                  # Kimlik doğrulama
│   │   ├── home/                  # Ana sayfa ve sekmeler
│   │   ├── products/              # Ürün yönetimi
│   │   ├── orders/                # Sipariş yönetimi
│   │   ├── addresses/             # Adres yönetimi
│   │   ├── appointments/          # Randevu yönetimi
│   │   ├── payment/                # Ödeme işlemleri
│   │   └── settings/              # Ayarlar
│   └── main.dart                  # Uygulama giriş noktası
├── assets/                        # Statik dosyalar
│   └── images/
└── pubspec.yaml                   # Dependencies ve konfigürasyon
```

## Kullanılan Paketler

### UI & Design
- `flutter` - Flutter framework
- `flutter_riverpod` - State management
- `cached_network_image` - Görsel önbellekleme

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
- `build_runner` - Kod üretimi
- `freezed` - Immutable sınıflar
- `json_serializable` - JSON serialization

## Tasarım Sistemi

### Renkler
- **Primary**: Material 3 Purple (#6750A4)
- **Success/Normal Price**: Green
- **Sale Price**: Red
- **Text**: Adaptive (light/dark theme)

### Typography
- **Font Family**: System default (Roboto/SF Pro)
- **Scales**: Material 3 type scale

## Platform Desteği

| Platform | Minimum Version | Status |
|----------|----------------|---------|
| iOS      | 15.0+          | ✅ Tested |
| Android  | API 21 (5.0)   | ✅ Ready |
| Web      | Modern browsers | ✅ Tested |

## Build

### Development Build
```bash
flutter build ios --debug
flutter build android --debug
```

### Production Build
```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols

# Web
flutter build web --release
```

### Optimized Android Build
```bash
./android_optimized_build.sh
```

## Test

```bash
# Unit testler
flutter test

# Widget testler
flutter test test/widget_test.dart
```

## Proje Durumu

**Toplam İlerleme**: ~95%

### Tamamlanan Özellikler
- ✅ Authentication System
- ✅ Ana Sayfa ve Navigasyon
- ✅ E-commerce Core (Ürünler, Sepet)
- ✅ Hizmetler ve Randevu Sistemi
- ✅ Sipariş Yönetimi
- ✅ Adres Yönetimi
- ✅ Ödeme Entegrasyonu (PayTR)
- ✅ Backend API Entegrasyonu

### Gelecek Özellikler
- 🔔 Push notifications
- ⭐ Product reviews & ratings
- ❤️ Wishlist/Favorites system
- 🔍 Advanced search & filters

## Katkıda Bulunma

1. Feature branch oluşturun
2. Değişikliklerinizi yapın
3. Test edin
4. Pull request gönderin

## Lisans

Bu proje özel/ticari kullanım içindir.

## İletişim

- **Geliştirici**: ICS Development Team
- **Proje**: ICS Mobile Application

---

**Son Güncelleme**: Ocak 2025  
**Versiyon**: 1.0.0+1  
**Flutter**: 3.2.0+  
**Dart**: 3.2.0+
