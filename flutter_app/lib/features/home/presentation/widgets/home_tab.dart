import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../featured/providers/featured_provider.dart' show featuredServicesProvider, featuredProductsProvider, featuredServicesListProvider, featuredProductsListProvider, FeaturedService;
import '../../../cart/providers/cart_provider.dart';
import '../../../services/providers/services_provider.dart' show servicesProvider;
import '../../../appointments/presentation/pages/appointment_booking_page.dart';
import '../../../notifications/presentation/pages/notifications_list_page.dart';
import '../../../../core/models/featured_model.dart';
import '../../../../core/models/service_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/utils/price_utils.dart';

class HomeTab extends ConsumerStatefulWidget {
  final void Function(int tabIndex)? onNavigateToTab;

  const HomeTab({super.key, this.onNavigateToTab});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  int _lastBuildTime = 0;

  @override
  void initState() {
    super.initState();
    // Refresh featured content when HomeTab is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshFeaturedContent();
    });
  }

  void _refreshFeaturedContent() {
    if (!mounted) return;
    // Refresh featured services and products
    ref.read(featuredServicesProvider.notifier).refresh();
    ref.read(featuredProductsProvider.notifier).refresh();
    // Also refresh base services provider since featured services depend on it
    ref.invalidate(servicesProvider);
  }

  @override
  Widget build(BuildContext context) {
    // Refresh featured content periodically when tab is visible (every 5 seconds)
    // This ensures data stays fresh even when user stays on Home tab
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastBuildTime > 5000) {
      _lastBuildTime = now;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshFeaturedContent();
      });
    }
    final authState = ref.watch(authProvider);
    final featuredServices = ref.watch(featuredServicesListProvider);
    final featuredProducts = ref.watch(featuredProductsListProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 60,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Innova Craft ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'S',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 't',
                style: TextStyle(
                  color: Colors.orange[600],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'u',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'd',
                style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'i',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'o',
                style: TextStyle(
                  color: Colors.orange[600],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                // Navigate to notifications page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NotificationsListPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Container(
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkSurface.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/ics_logo.jpg',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return (authState.user?.name != null && authState.user!.name!.isNotEmpty)
                                ? Text(
                                    _getInitials(authState.user!.name!),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Icon(Icons.person,
                                    color: Colors.white, size: 40);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (authState.user?.name != null && authState.user!.name!.isNotEmpty)
                                ? 'Hoş geldiniz, ${authState.user!.name}!'
                                : 'Hoş geldiniz!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Size nasıl yardımcı olabiliriz?',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions - 3 large buttons stacked vertically
            Column(
              children: [
                // Services Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.serviceCardBlue,
                    border: Border.all(
                      color: AppTheme.serviceCardBlue,
                      width: 2.5,
                    ),
                    boxShadow: [
                      // Neon edge glow - sadece kenarlarda
                      BoxShadow(
                        color: AppTheme.serviceCardBlue.withOpacity(0.7),
                        blurRadius: 12,
                        spreadRadius: -3,
                        offset: const Offset(0, 0),
                      ),
                      BoxShadow(
                        color: AppTheme.serviceCardBlue.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: -5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        // Navigate to services tab (index 1)
                        widget.onNavigateToTab?.call(1);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.work,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hizmetler',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Hizmetlerimizi Keşfedin',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Store Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppTheme.primaryOrange,
                    border: Border.all(
                      color: AppTheme.primaryOrange,
                      width: 2.5,
                    ),
                    boxShadow: [
                      // Neon edge glow - sadece kenarlarda
                      BoxShadow(
                        color: AppTheme.primaryOrange.withOpacity(0.7),
                        blurRadius: 12,
                        spreadRadius: -3,
                        offset: const Offset(0, 0),
                      ),
                      BoxShadow(
                        color: AppTheme.primaryOrange.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: -5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        // Navigate to catalog tab (index 3)
                        widget.onNavigateToTab?.call(3);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.store,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Mağaza',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Ürünlerimizi inceleyin',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // WhatsApp Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppTheme.whatsappGreen,
                    border: Border.all(
                      color: AppTheme.whatsappGreen,
                      width: 2.5,
                    ),
                    boxShadow: [
                      // Neon edge glow - sadece kenarlarda
                      BoxShadow(
                        color: AppTheme.whatsappGreen.withOpacity(0.7),
                        blurRadius: 12,
                        spreadRadius: -3,
                        offset: const Offset(0, 0),
                      ),
                      BoxShadow(
                        color: AppTheme.whatsappGreen.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: -5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        _launchWhatsApp(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.chat,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'WhatsApp',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'İletişime Geçin',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Featured Services
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Öne Çıkan Hizmetler',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 210,
              child: featuredServices.isEmpty
                  ? Center(
                      child: Card(
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_outline,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Henüz hizmet yok',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Yakında eklenecek',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredServices.length,
                      itemBuilder: (context, index) {
                        final service = featuredServices[index];
                        return _FeaturedServiceCard(
                          featuredService: service,
                          onNavigateToServices: () => widget.onNavigateToTab?.call(1),
                          onBookAppointment: () =>
                              _bookAppointmentFromFeaturedService(
                                  context, ref, service),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),

            // Featured Products
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOrange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Öne Çıkan Ürünler',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 230,
              child: featuredProducts.isEmpty
                  ? Center(
                      child: Card(
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_outlined,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Henüz öne çıkan ürün yok',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Yakında eklenecek',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredProducts.length,
                      itemBuilder: (context, index) {
                        final featuredProduct = featuredProducts[index];
                        return _FeaturedProductCard(
                          featuredProduct: featuredProduct,
                          onNavigateToCatalog: () => widget.onNavigateToTab?.call(3),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'U';
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '+905306435579';
    const message =
        'Merhaba! Innova Craft Studio üzerinden iletişime geçmek istiyorum.';
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'WhatsApp açılamadı';
      }
    } catch (e) {
      // Fallback: Show error message
      SnackBarService.showSnackBar(
        context: context,
        snackBar: SnackBar(
          content: Text('WhatsApp açılamadı: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _bookAppointmentFromFeaturedService(BuildContext context,
      WidgetRef ref, FeaturedService featuredService) async {
    // Check if user is authenticated
    final authState = ref.read(authProvider);

    if (!authState.isAuthenticated) {
      // Show login prompt
      SnackBarService.showSnackBar(
        context: context,
        snackBar: SnackBar(
          content: const Text('Randevu almak için giriş yapmalısınız'),
          backgroundColor: Colors.orange,
          action: SnackBarAction(
            label: 'Giriş Yap',
            textColor: Colors.white,
            onPressed: () {
              // Navigate to login page
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ),
      );
      return;
    }

    try {
      // Get the full service details
      final servicesAsync = await ref.read(servicesProvider.future);
      final service = servicesAsync.firstWhere(
        (s) => s.id == featuredService.id,
        orElse: () => Service(
          id: featuredService.id,
          title: featuredService.title ?? 'Hizmet',
          description: featuredService.description ?? '',
          image: featuredService.image,
          isUpcoming: featuredService.isUpcoming ?? false,
        ),
      );

      // Navigate to appointment booking page
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentBookingPage(service: service),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hizmet bilgileri alınamadı: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _FeaturedProductCard extends ConsumerWidget {
  final FeaturedProduct featuredProduct;
  final VoidCallback? onNavigateToCatalog;

  const _FeaturedProductCard({
    required this.featuredProduct,
    this.onNavigateToCatalog,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayPrice = featuredProduct.finalPrice ?? featuredProduct.price;
    final hasDiscount = featuredProduct.finalPrice != null &&
        featuredProduct.finalPrice! < featuredProduct.price!;
    final originalPrice = featuredProduct.price;

    return Container(
      width: 160,
      height: 210, // Even larger cards to prevent overflow
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: AppTheme.primaryOrange, // Bright orange border
          width: 3, // Thicker border
        ),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.primaryOrange.withOpacity(0.6), // Enhanced orange glow
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppTheme.primaryOrange.withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color:
                Colors.black.withOpacity(0.2), // Subtle black shadow for depth
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              onNavigateToCatalog?.call();
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    width: double.infinity,
                    height: 70, // Larger image height for better visibility
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    child: featuredProduct.images.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: featuredProduct.images.first,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: const Icon(
                                  Icons.inventory,
                                  color: AppTheme.primaryOrange,
                                  size: 32,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: const Icon(
                                  Icons.inventory,
                                  color: AppTheme.primaryOrange,
                                  size: 32,
                                ),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.inventory,
                            size: 40,
                            color: AppTheme.primaryOrange,
                          ),
                  ),
                  const SizedBox(height: 6),
                  // Product title
                  Text(
                    featuredProduct.title ?? 'Ürün',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 13, // Larger font size for better readability
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Product price
                  if (featuredProduct.price != null) ...[
                    Row(
                      children: [
                        Text(
                          '₺${displayPrice?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                            fontSize:
                                14, // Larger font size for better readability
                          ),
                        ),
                        if (hasDiscount && originalPrice != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '₺${originalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize:
                                  11, // Larger font size for better readability
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  // Category
                  if (featuredProduct.categoryName != null) ...[
                    Text(
                      featuredProduct.categoryName!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 11, // Larger font size for better readability
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                  ],
                  // Add to cart button or upcoming badge
                  if (featuredProduct.isUpcoming == true)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.primaryOrange.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Yakında',
                        style: TextStyle(
                          color: AppTheme.primaryOrange,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final isLoading = ref.watch(cartLoadingProvider);
                          return ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    // Add to cart functionality
                                    final cartNotifier =
                                        ref.read(cartProvider.notifier);
                                    try {
                                      await cartNotifier.addToCart(
                                        featuredProduct.id,
                                        quantity: 1,
                                        productTitle: featuredProduct.title,
                                        productPrice: featuredProduct.price,
                                      );
                                      if (context.mounted) {
                                        SnackBarService.showSnackBar(
                                          context: context,
                                          snackBar: SnackBar(
                                            content: Text(
                                                '${featuredProduct.title} sepete eklendi'),
                                            backgroundColor:
                                                AppTheme.successGreen,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        SnackBarService.showSnackBar(
                                          context: context,
                                          snackBar: SnackBar(
                                            content:
                                                Text('Hata: ${e.toString()}'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryOrange,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              isLoading ? 'Ekleniyor...' : 'Sepete Ekle',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedServiceCard extends StatelessWidget {
  final FeaturedService featuredService;
  final VoidCallback? onNavigateToServices;
  final VoidCallback? onBookAppointment;

  const _FeaturedServiceCard({
    required this.featuredService,
    this.onNavigateToServices,
    this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Colors.black : Colors.white;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final descriptionColor = isDarkTheme ? Colors.white70 : Colors.black87;

    return Container(
      width: 160,
      height: 190, // Even larger cards to prevent overflow
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: cardColor, // Theme-aware background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryNavy, // Shimmering blue border
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.6), // Enhanced blue glow
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Navigate directly to services tab on tap
            onNavigateToServices?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service image
                Container(
                  width: double.infinity,
                  height: 70, // Larger image height for better visibility
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isDarkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.05),
                  ),
                  child: featuredService.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: featuredService.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: isDarkTheme
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.05),
                              child: Icon(
                                Icons.work,
                                color: textColor,
                                size: 32,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: isDarkTheme
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.05),
                              child: Icon(
                                Icons.work,
                                color: textColor,
                                size: 32,
                              ),
                            ),
                          ),
                        )
                      : Icon(
                          Icons.work,
                          size: 40,
                          color: textColor,
                        ),
                ),
                const SizedBox(height: 8),
                // Service title
                Text(
                  featuredService.title ?? 'Hizmet',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13, // Larger font size for better readability
                    color: textColor, // Theme-aware text color
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Service description
                if (featuredService.description != null) ...[
                  Expanded(
                    child: Text(
                      featuredService.description!,
                      style: TextStyle(
                        color:
                            descriptionColor, // Theme-aware description color
                        fontSize: 11, // Larger font size for better readability
                      ),
                      maxLines: 2, // More lines for better readability
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                // Appointment button or upcoming badge
                if (featuredService.isUpcoming == true)
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDarkTheme
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Yakında',
                      style: TextStyle(
                        color: textColor, // Theme-aware text color
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Call the appointment booking callback
                        onBookAppointment?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDarkTheme ? Colors.white : AppTheme.primaryNavy,
                        foregroundColor:
                            isDarkTheme ? AppTheme.primaryNavy : Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Randevu Al',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
