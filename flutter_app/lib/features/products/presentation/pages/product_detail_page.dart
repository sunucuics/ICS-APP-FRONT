import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../comments/presentation/widgets/rating_summary.dart';
import '../../../comments/presentation/widgets/comments_list.dart';
import '../../../comments/presentation/widgets/comment_form.dart';
import '../../../comments/presentation/pages/comments_page.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/utils/price_utils.dart';

class _ImageGalleryViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _ImageGalleryViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_ImageGalleryViewer> createState() => _ImageGalleryViewerState();
}

class _ImageGalleryViewerState extends State<_ImageGalleryViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: widget.images.length > 1
            ? Text(
                '${_currentIndex + 1} / ${widget.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const ClampingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.images[index]),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.images[index],
                ),
              );
            },
            itemCount: widget.images.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                          event.expectedTotalBytes!,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryOrange,
                  ),
                ),
              ),
            ),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // Görsel indicator (sadece birden fazla görsel varsa)
          if (widget.images.length > 1)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? AppTheme.primaryOrange
                          : Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  int selectedImageIndex = 0;
  int quantity = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showImageGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ImageGalleryViewer(
          images: widget.product.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  void _showCommentForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Yorum Ekle',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Comment form
            Expanded(
              child: CommentForm(
                targetId: widget.product.id,
                targetType: 'product',
                onCommentAdded: () {
                  Navigator.of(context).pop();
                  // Refresh comments if needed
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final displayPrice = product.finalPrice ?? product.price;
    final hasDiscount =
        product.finalPrice != null && product.finalPrice! < product.price;
    final originalPrice = product.price;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: AppTheme.primaryOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryOrange,
                AppTheme.primaryOrange.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryOrange,
                  AppTheme.primaryOrange.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // Product Images
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Swipeable Images with PageView
                  Container(
                    height: 350,
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: product.images.isNotEmpty
                          ? GestureDetector(
                              onTap: () => _showImageGallery(context, selectedImageIndex),
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    selectedImageIndex = index;
                                  });
                                },
                                itemCount: product.images.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: product.images[index],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                  AppTheme.primaryOrange),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant,
                                          child: const Icon(
                                            Icons.image_not_supported,
                                            size: 64,
                                            color: AppTheme.primaryOrange,
                                          ),
                                        ),
                                      ),
                                      // Zoom icon overlay
                                      Positioned(
                                        top: 12,
                                        right: 12,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.zoom_in,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Container(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: AppTheme.primaryOrange,
                              ),
                            ),
                    ),
                  ),

                  // Image indicator dots (only if more than 1 image)
                  if (product.images.length > 1) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        product.images.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedImageIndex == index
                                ? AppTheme.primaryOrange
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Product Info with enhanced design
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Category
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (product.categoryName != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.primaryOrange.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              product.categoryName!,
                              style: const TextStyle(
                                color: AppTheme.primaryOrange,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),

                        // Price with enhanced design
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryOrange.withOpacity(0.1),
                                AppTheme.primaryOrange.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fiyat',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₺${displayPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (hasDiscount) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₺${originalPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        '${(((product.price - displayPrice) / product.price) * 100).round()}% İndirim',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Stock Status with enhanced design
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: product.stock > 0
                                ? AppTheme.successGreen.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: product.stock > 0
                                  ? AppTheme.successGreen.withOpacity(0.3)
                                  : Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: product.stock > 0
                                      ? AppTheme.successGreen
                                      : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  product.stock > 0
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stok Durumu',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      product.stock > 0
                                          ? 'Stokta var'
                                          : 'Stokta yok',
                                      style: TextStyle(
                                        color: product.stock > 0
                                            ? AppTheme.successGreen
                                            : Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (product.isUpcoming) ...[
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Yakında Satışta',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Bu ürün yakında satışa sunulacak',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),

                        // Quantity Selector with enhanced design
                        if (product.stock > 0 && !product.isUpcoming) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Adet:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline
                                            .withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: quantity > 1
                                            ? () {
                                                setState(() {
                                                  quantity--;
                                                });
                                              }
                                            : null,
                                        icon: const Icon(Icons.remove),
                                        style: IconButton.styleFrom(
                                          foregroundColor: quantity > 1
                                              ? AppTheme.primaryOrange
                                              : Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        child: Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: quantity < product.stock
                                            ? () {
                                                setState(() {
                                                  quantity++;
                                                });
                                              }
                                            : null,
                                        icon: const Icon(Icons.add),
                                        style: IconButton.styleFrom(
                                          foregroundColor:
                                              quantity < product.stock
                                                  ? AppTheme.primaryOrange
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Description with enhanced design
                        if (product.description != null &&
                            product.description!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ürün Açıklaması',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  product.description!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Rating Summary
                        RatingSummary(
                          targetId: product.id,
                          targetType: 'product',
                        ),

                        // Comments Section with enhanced design
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Yorumlar',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      // Add comment button
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: _showCommentForm,
                                          icon: const Icon(Icons.add_comment,
                                              size: 16),
                                          label: const Text('Yorum Ekle'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppTheme.primaryOrange,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // View all comments button
                                      Expanded(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentsPage(
                                                  targetId: product.id,
                                                  targetType: 'product',
                                                  targetTitle: product.title,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.comment_outlined,
                                              size: 16),
                                          label: const Text('Tümünü Gör'),
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppTheme.primaryOrange,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Comments Preview (show first 3 comments)
                        SizedBox(
                          height: 300,
                          child: CommentsList(
                            targetId: product.id,
                            targetType: 'product',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar with enhanced design
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Total price
                if (product.stock > 0 && !product.isUpcoming) ...[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Toplam',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₺${(displayPrice * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],

                // Add to Cart Button
                Expanded(
                  flex: product.stock > 0 && !product.isUpcoming ? 2 : 1,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isLoading = ref.watch(cartLoadingProvider);
                      return ElevatedButton.icon(
                        onPressed: (product.stock > 0 &&
                                !product.isUpcoming &&
                                !isLoading)
                            ? () => _addToCart(context, ref)
                            : null,
                        icon: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Icon(Icons.shopping_cart, size: 20),
                        label: Text(
                          isLoading
                              ? 'Ekleniyor...'
                              : product.isUpcoming
                                  ? 'Yakında Satışta'
                                  : product.stock > 0
                                      ? 'Sepete Ekle'
                                      : 'Stokta Yok',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (product.stock > 0 &&
                                  !product.isUpcoming &&
                                  !isLoading)
                              ? AppTheme.primaryOrange
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(cartProvider.notifier).addToCart(
            widget.product.id,
            quantity: quantity,
            productTitle: widget.product.title,
            productPrice: widget.product.price,
          );

      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content:
                Text('${widget.product.title} sepete eklendi ($quantity adet)'),
            duration: const Duration(seconds: 2),
            // Remove action button, just show notification
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
