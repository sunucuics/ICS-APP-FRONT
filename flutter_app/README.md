# ICS Mobile App - Flutter

🛍️ **ICS (Individual Commerce System)** - Modern e-ticaret ve hizmet rezervasyon mobil uygulaması.

## 📖 Proje Hakkında

ICS App, kullanıcıların ürün satın alabildiği, hizmet rezervasyonu yapabildiği ve randevu alabildiği modern bir Flutter mobil uygulamasıdır. Material 3 tasarım sistemi ile responsive ve kullanıcı dostu bir deneyim sunar.

## 🎯 **MEVCUT DURUM ANALİZİ** *(Ocak 2025)*

### ✅ **TAMAMLANAN ÖZELLİKLER** *(%85 Tamamlandı)*

#### 🔐 **Authentication System** *(%100)*
- ✅ Firebase Authentication entegrasyonu
- ✅ Email/password login & register
- ✅ Token management ve auto-refresh
- ✅ Protected routes implementation
- ✅ Secure storage (flutter_secure_storage)

#### 🏠 **Ana Sayfa (Home Tab)** *(%100)*
- ✅ Kullanıcı karşılama mesajı ve avatar
- ✅ Quick actions (Hizmetler, Mağaza, WhatsApp)
- ✅ Featured services ve products (backend entegrasyonu)
- ✅ Navigation integration ve tab switching

#### 🛠️ **Hizmetler (Services Tab)** *(%100)*
- ✅ Backend'den hizmet listesi çekme
- ✅ Service detail modal görüntüleme
- ✅ Appointment booking UI
- ✅ Image support ve fallback handling

#### 🛒 **E-commerce Core** *(%100)*
- ✅ Product catalog ve kategori filtreleme
- ✅ Search functionality (debounced)
- ✅ Shopping cart system (full backend integration)
- ✅ Add/remove items ve quantity management
- ✅ Real-time total calculation
- ✅ Cart persistence

#### 👤 **Profil (Profile Tab)** *(%90)*
- ✅ User profile display
- ✅ Logout functionality
- ✅ Menu items (placeholder'lar mevcut)

#### 📡 **Backend Integration** *(%100)*
- ✅ API client setup (Dio)
- ✅ Authentication interceptors
- ✅ Data models (Freezed + JSON serialization)
- ✅ State management (Riverpod)
- ✅ Error handling ve user feedback

### 🚧 **EKSİK KALAN ÖZELLİKLER** *(%15 Kaldı)*

#### 📦 **Order Management System** *(%0)*
- ❌ Order models ve API service
- ❌ Orders list page (Siparişlerim)
- ❌ Order detail page
- ❌ Order tracking system
- ❌ Checkout flow (sepetten siparişe)

#### 🏠 **Address Management System** *(%0)*
- ❌ Address models ve API service
- ❌ Address CRUD operations
- ❌ Address selection for orders
- ❌ Default address management

#### ⭐ **Featured Content Integration** *(%0)*
- ❌ Featured products backend entegrasyonu
- ❌ Featured services backend entegrasyonu
- ❌ Admin panel featured management

#### 👤 **Anonymous Authentication** *(%0)*
- ❌ Guest mode (misafir girişi)
- ❌ Anonymous user support
- ❌ Guest to registered user upgrade

#### 💳 **Payment Integration** *(%0)*
- ❌ Iyzico payment gateway
- ❌ Payment flow implementation
- ❌ WebView integration for payments
- ❌ Payment success/failure handling

#### 🔔 **Advanced Features** *(%0)*
- ❌ Push notifications (Firebase Messaging)
- ❌ Product reviews & ratings
- ❌ Wishlist/Favorites system
- ❌ Advanced search & filters

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

## 🚀 **GELİŞTİRME PLANI** *(4-6 Hafta)*

### **SPRINT 1: Order Management System** *(1-2 hafta)*
**Öncelik: 🔥 YÜKSEK** - Sepet tamamlandı, sipariş sistemi eksik

#### 1.1 Order Models & API Integration
```dart
// Yeni dosyalar:
lib/core/models/order_model.dart
lib/features/orders/data/orders_api_service.dart
lib/features/orders/data/orders_repository.dart
lib/features/orders/providers/orders_provider.dart
```

#### 1.2 Order Pages
```dart
// Yeni sayfalar:
lib/features/orders/presentation/pages/
├── orders_list_page.dart          // "Siparişlerim" sayfası
├── order_detail_page.dart         // Sipariş detayı
└── order_tracking_page.dart       // Sipariş takibi
```

#### 1.3 Checkout Flow
```dart
// Checkout sistemi:
lib/features/checkout/presentation/pages/
├── checkout_page.dart             // Sepetten siparişe
├── address_selection_page.dart    // Adres seçimi
└── order_confirmation_page.dart   // Sipariş onayı
```

**Backend API Endpoints:**
- ✅ `POST /orders/` - Sipariş oluştur
- ✅ `GET /orders/my` - Kullanıcının siparişleri
- ✅ `GET /orders/{id}` - Sipariş detayı
- ✅ `POST /orders/{id}/sync-status` - Durum senkronizasyonu

---

### **SPRINT 2: Address Management System** *(1 hafta)*
**Öncelik: 🔥 YÜKSEK** - Sipariş için gerekli

#### 2.1 Address Models & API
```dart
// Adres yönetimi:
lib/core/models/address_model.dart
lib/features/addresses/data/addresses_api_service.dart
lib/features/addresses/data/addresses_repository.dart
lib/features/addresses/providers/addresses_provider.dart
```

#### 2.2 Address Pages
```dart
// Adres sayfaları:
lib/features/addresses/presentation/pages/
├── addresses_list_page.dart       // Adreslerim
├── add_address_page.dart          // Yeni adres ekle
└── edit_address_page.dart         // Adres düzenle
```

**Backend API Endpoints:**
- ✅ `GET /users/me/addresses` - Adres listesi
- ✅ `POST /users/me/addresses` - Adres ekle
- ✅ `PUT /users/me/addresses/{id}` - Adres güncelle
- ✅ `DELETE /users/me/addresses/{id}` - Adres sil
- ✅ `PUT /users/me/addresses/{id}/select` - Varsayılan adres seç
- ✅ `GET /users/me/addresses/current` - Mevcut adres

---

### **SPRINT 3: Featured Content Integration** *(1 hafta)*
**Öncelik: 🟡 ORTA** - Ana sayfa için

#### 3.1 Featured API Integration
```dart
// Featured content:
lib/features/featured/data/featured_api_service.dart
lib/features/featured/providers/featured_provider.dart
```

#### 3.2 Home Page Updates
```dart
// Ana sayfa güncellemeleri:
lib/features/home/presentation/widgets/home_tab.dart
// - Featured products backend entegrasyonu
// - Featured services backend entegrasyonu
```

**Backend API Endpoints:**
- ✅ `GET /admin/featured/products` - Öne çıkan ürünler
- ✅ `GET /admin/featured/services` - Öne çıkan hizmetler
- ✅ `POST /admin/featured/products/{id}` - Ürün öne çıkar
- ✅ `POST /admin/featured/services/{id}` - Hizmet öne çıkar

---

### **SPRINT 4: Anonymous Authentication** *(1 hafta)*
**Öncelik: 🟡 ORTA** - Misafir kullanıcı desteği

#### 4.1 Guest Mode Implementation
```dart
// Misafir modu:
lib/features/auth/data/guest_auth_service.dart
lib/features/auth/providers/guest_provider.dart
lib/features/auth/presentation/pages/guest_mode_page.dart
```

#### 4.2 Auth Flow Updates
```dart
// Auth güncellemeleri:
lib/core/widgets/auth_wrapper.dart
lib/features/auth/presentation/pages/login_page.dart
// - "Misafir devam et" butonu
// - Anonymous Firebase Auth
// - Guest to registered upgrade
```

**Firebase Configuration:**
- ✅ Anonymous Authentication enable
- ✅ Guest user support
- ✅ Token management for guests

---

### **SPRINT 5: Mock Payment System** *(1 hafta)*
**Öncelik: 🔥 YÜKSEK** - Iyzico için APK gerekli, şimdilik mock

#### 5.1 Mock Payment Implementation
```dart
// Geçici ödeme sistemi:
lib/features/payment/data/mock_payment_service.dart
lib/features/payment/presentation/pages/
├── payment_page.dart              // Ödeme sayfası (mock)
├── payment_success_page.dart      // Başarılı ödeme
└── payment_failure_page.dart      // Başarısız ödeme
```

#### 5.2 Checkout Flow Integration
```dart
// Checkout güncellemeleri:
lib/features/checkout/presentation/pages/checkout_page.dart
// - Payment method selection (mock)
// - Mock payment simulation
// - Order completion
```

#### 5.3 Iyzico Integration (APK Sonrası)
```dart
// Gerçek Iyzico entegrasyonu (APK hazır olduktan sonra):
lib/features/payment/data/iyzico_payment_service.dart
lib/features/payment/presentation/widgets/
└── iyzico_webview.dart            // Iyzico ödeme formu
```

**Not:** Iyzico entegrasyonu APK hazır olduktan sonra yapılacak. Şimdilik mock payment ile sipariş akışı tamamlanacak.

---

## 💳 **IYZICO ENTEGRASYON STRATEJİSİ**

### **Aşama 1: Mock Payment (Şimdi)**
- ✅ Mock payment service implementation
- ✅ Payment simulation (başarılı/başarısız)
- ✅ Checkout flow completion
- ✅ Order creation with mock payment
- ✅ APK build için hazırlık

### **Aşama 2: APK Submission (4-6 hafta sonra)**
- 📱 Tamamlanmış uygulama APK'sı
- 📋 Iyzico'ya APK gönderimi
- ⏳ Iyzico onay süreci (1-2 hafta)

### **Aşama 3: Real Integration (APK onayı sonrası)**
- 🔄 Mock payment → Real Iyzico integration
- 🌐 WebView implementation
- 🧪 Production testing
- 🚀 Live deployment

**Avantajlar:**
- ✅ Sipariş akışı şimdi tamamlanabilir
- ✅ APK hazır olduğunda Iyzico'ya gönderilebilir
- ✅ Mock → Real geçiş kolay olacak
- ✅ Development süreci kesintisiz devam eder

---

### **SPRINT 6: Advanced Features** *(2 hafta)*
**Öncelik: 🟢 DÜŞÜK** - Launch sonrası

#### 6.1 Push Notifications
```dart
// Bildirimler:
lib/core/notifications/
├── notification_service.dart
└── notification_handler.dart
```

#### 6.2 Product Reviews & Ratings
```dart
// Yorum sistemi:
lib/features/reviews/
├── data/reviews_api_service.dart
├── presentation/pages/reviews_page.dart
└── presentation/widgets/rating_widget.dart
```

#### 6.3 Wishlist/Favorites
```dart
// Favoriler:
lib/features/favorites/
├── data/favorites_api_service.dart
├── providers/favorites_provider.dart
└── presentation/pages/favorites_page.dart
```

---

## 📋 **BACKEND API DURUMU** *(%100 Hazır)*

### ✅ **Mevcut Endpoints**
- **Authentication**: `/auth/login`, `/auth/register`, `/auth/logout`
- **Users**: `/users/me`, `/users/me/addresses/*`
- **Products**: `/products`, `/products/{id}`
- **Services**: `/services`, `/services/{id}`
- **Cart**: `/cart`, `/cart/items/*`
- **Orders**: `/orders/*`, `/admin/orders/*`
- **Featured**: `/admin/featured/products/*`, `/admin/featured/services/*`
- **Categories**: `/categories`

### 🔧 **Backend Özellikler**
- ✅ Firebase Authentication
- ✅ Firestore Database
- ✅ Aras Kargo Integration
- ✅ Admin Panel Support
- ✅ Address Management
- ✅ Order Tracking
- ✅ Featured Content Management

## 🎯 **ÖNCELİK SIRASI** *(Hemen Başlanacak)*

### **1. Order Management System** 🔥
**Neden öncelik:** Sepet tamamlandı ama sipariş oluşturma eksik. Bu olmadan uygulama tam fonksiyonel değil.

**İlk adımlar:**
1. Order model oluşturma
2. Orders API service entegrasyonu
3. Orders list page (Siparişlerim)
4. Order detail page
5. Checkout flow (sepetten siparişe)

### **2. Address Management System** 🔥
**Neden öncelik:** Sipariş için adres gerekli. Backend hazır, sadece frontend implementasyonu.

**İlk adımlar:**
1. Address model oluşturma
2. Address API service entegrasyonu
3. Address CRUD pages
4. Address selection for orders

### **3. Mock Payment System** 🔥
**Neden öncelik:** Iyzico için APK gerekli, şimdilik mock payment ile sipariş akışı tamamlanacak.

**İlk adımlar:**
1. Mock payment service implementation
2. Payment simulation (başarılı/başarısız)
3. Checkout flow integration
4. Order completion with mock payment

---

## 🐛 **Bilinen Sorunlar**

- ~~Overflow hatalar~~ ✅ Çözüldü
- ~~Fiyat renk problemi~~ ✅ Çözüldü
- ~~Firebase entegrasyonu~~ ✅ Tamamlandı
- ~~API endpoints~~ ✅ Tamamlandı
- ❌ **Order Management System eksik** - En kritik eksiklik
- ❌ **Address Management eksik** - Sipariş için gerekli
- ❌ **Mock Payment System eksik** - Iyzico için APK gerekli, şimdilik mock

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

---

## 📊 **PROJE İLERLEME DURUMU**

```
🚀 Proje Kurulumu     ████████████████████ 100%
📱 Flutter App        ████████████████▒▒▒▒  85%
🖥️ Admin Panel        ████████▒▒▒▒▒▒▒▒▒▒▒▒  40%
🔧 Backend API        ████████████████████ 100%
🎨 UI/UX Design       ██████████████████▒▒  90%
🔐 Authentication     ████████████████████ 100%
📡 API Integration    ████████████████▒▒▒▒  80%
```

**Toplam İlerleme**: **~85%**

---

## 🎯 **SONRAKI ADIMLAR**

### **Bu Hafta (Sprint 1)**
1. **Order Management System** implementasyonu
2. **Address Management System** implementasyonu
3. **Checkout Flow** geliştirme

### **Gelecek 2 Hafta (Sprint 2-3)**
1. **Mock Payment System** (Iyzico için APK hazır olana kadar)
2. **Featured Content** backend entegrasyonu
3. **Anonymous Authentication** (misafir modu)

### **Launch Hazırlığı (4-6 hafta)**
1. **Performance Optimization**
2. **Security Audit**
3. **APK Build & Iyzico Submission**
4. **Real Iyzico Integration** (APK onayı sonrası)
5. **App Store Submission**
6. **Production Deployment**

---

**Son Güncelleme**: Ocak 2025
**Versiyon**: 1.0.0+1
**Flutter**: 3.2.0+
**Dart**: 3.2.0+
**Backend**: FastAPI + Firebase + Firestore
**Durum**: Aktif Geliştirme - Order Management Sprint'i başlıyor