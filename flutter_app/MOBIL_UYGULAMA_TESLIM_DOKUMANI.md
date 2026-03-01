# Innova Craft Studio – Mobil Uygulama Teslim Dokümanı

Bu doküman, **Innova Craft Studio** mobil uygulamasının teknik özelliklerini, özelliklerini ve teslim bilgilerini müşteriye sunmak amacıyla hazırlanmıştır.

---

## 1. Uygulama Özeti

| Bilgi | Değer |
|-------|--------|
| **Uygulama adı** | Innova Craft Studio |
| **Açıklama** | El yapımı ürünler ve sanat eserleri – mağaza, hizmet randevuları ve sipariş yönetimi |
| **Mevcut sürüm** | 1.3.19 (build 42) |
| **Platform** | Android, iOS |
| **Geliştirme framework** | Flutter (Dart SDK ≥3.2.0) |

---

## 2. Teknik Altyapı

### 2.1 Kullanılan Teknolojiler

- **Flutter** – Cross-platform mobil arayüz
- **Riverpod** – Durum yönetimi (state management)
- **Dio** – HTTP istekleri ve API iletişimi
- **Firebase** – Kimlik doğrulama (Auth), push bildirimler (FCM)
- **Flutter Secure Storage** – Token ve hassas veri saklama
- **SharedPreferences** – Tema, ilk açılış gibi basit tercihler
- **Freezed + json_serializable** – Veri modelleri ve JSON serileştirme
- **WebView** – Ödeme sayfası (PayTR entegrasyonu)
- **Table Calendar** – Randevu takvimi
- **Cached Network Image** – Görsel önbellekleme
- **Photo View** – Ürün görselleri büyütme
- **Video Player** – Açılış / tanıtım videosu
- **flutter_local_notifications** – Yerel bildirimler
- **flutter_app_badger** – Uygulama ikonu rozet sayısı

### 2.2 Backend Bağlantısı

- **Canlı (production) API:** `https://api.innovacraftstudio.com`
- Debug modda uygulama yerel sunucuya yönlendirilebilir (geliştirme için).

---

## 3. Kullanıcı Özellikleri (Müşteri Tarafı)

### 3.1 Giriş ve Hesap

- **Misafir kullanım:** Kayıt olmadan mağaza ve hizmetleri gezme; istendiğinde hesaba geçiş.
- **Kayıt / Giriş:** E-posta ve şifre ile kayıt ve giriş.
- **Profil:** Profil bilgileri, tema (açık/koyu), çıkış, hesap silme vb.

### 3.2 Ana Ekran ve Navigasyon

Uygulama açıldıktan sonra alt sekmeli (bottom navigation) bir ana sayfa sunar:

| Sekme | Açıklama |
|-------|----------|
| **Ana Sayfa** | Öne çıkan içerikler, kategoriler, hızlı erişim |
| **Hizmetler** | Randevu alınabilen hizmetler listesi ve detay |
| **Sepet** | Sepet özeti, ödeme adımına geçiş |
| **Mağaza** | Kategoriler ve ürün listesi |
| **Profil** | Hesap, adresler, siparişlerim, randevularım, bildirimler, ayarlar |

- **Açılış:** İlk kurulumda kısa bir tanıtım videosu, sonraki açılışlarda doğrudan giriş/welcome veya ana sayfa.
- **Tema:** Açık ve koyu tema seçilebilir; sistem tercihine göre otomatik de ayarlanabilir.

### 3.3 Mağaza (Ürünler)

- Kategorilere göre ürün listeleme
- Ürün detayı: görseller, fiyat, açıklama, yorumlar
- Sepete ekleme
- Yorum ve puanlama görüntüleme

### 3.4 Sepet ve Ödeme

- Sepette ürün ekleme / güncelleme / silme
- Teslimat adresi seçimi veya yeni adres ekleme
- **PayTR** ile güvenli ödeme (WebView üzerinden 3D Secure)
- Ödeme sonrası başarı sayfası ve sipariş takibi

### 3.5 Siparişler

- Sipariş listesi (geçmiş ve güncel)
- Sipariş detayı: ürünler, tutar, adres, durum

### 3.6 Adresler

- Kayıtlı adres listesi
- Yeni adres ekleme ve düzenleme
- Varsayılan teslimat adresi seçimi

### 3.7 Hizmetler ve Randevular

- Hizmet listesi ve hizmet detayı
- Takvim üzerinden randevu seçimi ve randevu oluşturma
- “Randevularım” ekranında randevu listesi ve detay

### 3.8 Bildirimler

- Push bildirimler (Firebase Cloud Messaging)
- Uygulama içi bildirim listesi
- Uygulama ikonu rozetinde okunmamış bildirim sayısı

### 3.9 Yorumlar

- Ürün/hizmet yorumları ve puanlamaların görüntülemesi (uygulama içi yorum listesi sayfası)

### 3.10 Çoklu Dil

- **Türkçe (tr-TR)** – Varsayılan
- **İngilizce (en-US)** – Desteklenen ikinci dil  
*(Metinler `intl` ve Flutter yerelleştirme altyapısı ile yönetilir.)*

---

## 4. Yönetici (Admin) Özellikleri

Admin yetkisine sahip kullanıcılar giriş yaptığında normal ana sayfa yerine **Admin paneli** görür. Soldan sekmeli menü ile aşağıdaki modüllere erişilir:

| Modül | Açıklama |
|--------|----------|
| **Dashboard** | Özet istatistikler, hızlı bilgiler |
| **Kategoriler** | Ürün kategorileri ekleme, düzenleme, listeleme |
| **Ürünler** | Ürün CRUD, stok, fiyat |
| **Siparişler** | Sipariş kuyruğu (hazırlanıyor, kargoda, teslim edildi), sipariş detayı ve durum güncelleme |
| **Randevular** | Randevu listesi ve yönetimi |
| **İndirimler** | İndirim kampanyaları tanımlama ve yönetimi |
| **Hizmetler** | Randevu alınan hizmetlerin yönetimi |
| **Kullanıcılar** | Kullanıcı listesi ve yönetimi |
| **Yorumlar** | Yorumları görüntüleme / yönetme |
| **Bildirimler** | Push bildirim gönderme, bildirim geçmişi |
| **Ayarlar** | Uygulama / ödeme (PayTR) vb. genel ayarlar |

Admin arayüzü açık/koyu temayı destekler ve mobil ekrana uyumludur.

---

## 5. Güvenlik ve Veri

- **Kimlik doğrulama:** JWT tabanlı; access + refresh token kullanımı.
- **Token saklama:** Flutter Secure Storage ile cihazda güvenli saklama.
- **Ödeme:** Kredi kartı bilgisi uygulama içinde tutulmaz; PayTR sayfası WebView’da açılır (3D Secure).
- **API iletişimi:** Production ortamında HTTPS kullanılır.

---

## 6. Platform Gereksinimleri

- **Android:** minSdk (Flutter varsayılanı, genelde API 21+), hedef SDK ve derleme SDK proje ayarlarına göre (ör. compileSdk 36).
- **iOS:** Proje içindeki `ios/` ayarlarına göre (minimum iOS sürümü `ios/Podfile` veya Xcode projesinde belirtilir).
- **Orientasyon:** Android’de varsayılan olarak dikey (portrait) kilitlenebilir; ihtiyaca göre değiştirilebilir.

---

## 7. Derleme ve Teslim

### 7.1 Gereksinimler

- Flutter SDK (≥3.2.0)
- Android Studio / Xcode (platforma göre)
- Firebase projesi (Auth + FCM) ve uygulamaya eklenmiş `google-services.json` (Android) / `GoogleService-Info.plist` (iOS)
- PayTR hesabı ve backend’de ödeme entegrasyonu

### 7.2 Proje Konumu ve Sürüm

- Proje kökü: `flutter_app/` klasörü
- Sürüm ve build numarası: `pubspec.yaml` içinde `version: 1.3.19+42` (sürüm+build)

### 7.3 Release Derleme (Özet)

- **Android:**  
  `flutter build apk` veya `flutter build appbundle`  
  Release imzalama için `android/app/key.properties` ve ilgili keystore tanımlı olmalı.

- **iOS:**  
  `flutter build ios`  
  Xcode üzerinden imzalama ve App Store Connect’e yükleme yapılır.

### 7.4 Teslim Edilecek Çıktılar (Örnek)

- **Google Play:** AAB (Android App Bundle) veya APK
- **App Store:** Xcode ile arşiv alınıp App Store Connect’e yüklenen build
- İsteğe bağlı: kaynak kodu arşivi, bu teslim dokümanı, kısa kullanım notu

---

## 8. Özet

Innova Craft Studio mobil uygulaması:

- **Müşteri tarafında:** Mağaza, sepette alışveriş, PayTR ile ödeme, randevu, sipariş ve adres yönetimi, bildirimler ve çoklu dil (TR/EN) sunar.
- **Admin tarafında:** Kategori, ürün, sipariş, randevu, indirim, hizmet, kullanıcı, yorum, bildirim ve ayarlar tek ekrandan yönetilir.
- **Teknik olarak:** Flutter ile Android ve iOS’ta çalışır; Firebase (Auth, FCM), JWT ve PayTR WebView ile güvenli ve ölçeklenebilir bir yapı hedeflenmiştir.

Bu doküman, teslim sırasında müşteriye verilebilir ve gerektiğinde sürüm numarası ile tarih eklenerek güncellenebilir.

---

*Son güncelleme: Proje mevcut haliyle (Şubat 2025) uygulama yapısına göre hazırlanmıştır.*
