import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  static const Color bgColor = Color(0xFFF8F6F0);
  static const Color cardBg = Colors.white;
  static const Color primaryGreen = Color(0xFF2F3E33);
  static const Color bannerBg = Color(0xFFE2EBE0);
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color bottomBarBorder = Color(0xFFDDDCD5);

  int _currentBottomNav = 4;
  int _currentBannerIndex = 0; // State untuk Carousel M06
  final PageController _bannerController = PageController();

  // Data Carousel Banner (Materi M06)
  final List _bannerTips = [
    {
      'icon': Icons.favorite_border,
      'title': 'Good finds are worth keeping.',
      'subtitle': "We'll let you know when a price drops.",
    },
    {
      'icon': Icons.local_offer_outlined,
      'title': 'Bundle & save on shipping.',
      'subtitle': 'Buy 2+ pieces from the same closet for discounts.',
    },
    {
      'icon': Icons.eco_outlined,
      'title': 'Circular fashion matters.',
      'subtitle': 'Every preloved piece saves water and carbon.',
    },
  ];

  final List _favoriteItems = [
    {
      'brandSize': 'MUJI • M',
      'title': 'Linen Work Jacket',
      'condition': '90% Good',
      'price': 'Rp 185k',
      'oldPrice': '',
      'image': 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
    },
    {
      'brandSize': 'UNIQLO • S',
      'title': 'Pleated Midi Skirt',
      'condition': 'Like New',
      'price': 'Rp 120k',
      'oldPrice': '',
      'image': 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=500',
    },
    {
      'brandSize': 'POLO • L',
      'title': 'Vintage Rugby Polo',
      'condition': '80% Good',
      'price': 'Rp 210k',
      'oldPrice': '',
      'image': 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500',
    },
    {
      'brandSize': 'BAGGU • One size',
      'title': 'Canvas City Tote',
      'condition': '90% Good',
      'price': 'Rp 95k',
      'oldPrice': 'Rp 110k',
      'image': 'https://images.unsplash.com/photo-1544816155-12df9643f363?w=500',
    },
  ];

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // M07: Menggunakan MediaQuery untuk mendeteksi ukuran & orientasi layar
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textDark,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 16, color: textDark),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 16, color: textDark),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 16, color: textDark),
                    ],
                  ),
                ],
              ),
            ),

            // Top bar
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_left, color: textDark, size: 24),
                    ),
                  ),
                  const Text(
                    'Your Favorites',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: textDark,
                      letterSpacing: -0.4,
                    ),
                  ),
                  // M06: Stack + Positioned untuk Badge jumlah favorit
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border, color: textDark, size: 20),
                      ),
                      if (_favoriteItems.isNotEmpty)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: primaryGreen,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${_favoriteItems.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Content dengan M07 LayoutBuilder (Adaptive UI)
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Jika layar lebar / landscape (>= 600px), gunakan 2 kolom GridView
                  final bool useGrid = constraints.maxWidth >= 600 || isLandscape;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 800 ? screenWidth * 0.1 : 20,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // M06: CAROUSEL BANNER (PageView.builder + Dot Indicator)
                        Container(
                          height: 76,
                          decoration: BoxDecoration(
                            color: bannerBg,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _bannerController,
                                itemCount: _bannerTips.length,
                                onPageChanged: (idx) {
                                  setState(() => _currentBannerIndex = idx);
                                },
                                itemBuilder: (context, index) {
                                  final tip = _bannerTips[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                    child: Row(
                                      children: [
                                        Icon(tip['icon'] as IconData, color: primaryGreen, size: 22),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                tip['title'] as String,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: textDark,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                tip['subtitle'] as String,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: textMuted,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // Indikator titik Carousel
                              Positioned(
                                bottom: 6,
                                right: 14,
                                child: Row(
                                  children: List.generate(_bannerTips.length, (dotIndex) {
                                    bool active = _currentBannerIndex == dotIndex;
                                    return Container(
                                      width: active ? 12 : 5,
                                      height: 5,
                                      margin: const EdgeInsets.only(left: 4),
                                      decoration: BoxDecoration(
                                        color: active
                                            ? primaryGreen
                                            : primaryGreen.withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Saved Pieces Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_favoriteItems.length} saved pieces',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: textDark,
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Recently saved',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: textMuted,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.keyboard_arrow_down, size: 18, color: textMuted),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // M06 & M07: Adaptive ListView.builder (Portrait) vs GridView.builder (Landscape/Tablet)
                        if (useGrid)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 122,
                            ),
                            itemCount: _favoriteItems.length,
                            itemBuilder: (context, index) => _buildFavoriteCard(index),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _favoriteItems.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) => _buildFavoriteCard(index),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Nav
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: bottomBarBorder, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(icon: Icons.home_outlined, label: 'Home', index: 0),
                  _buildNavItem(icon: Icons.search, label: 'Search', index: 1),
                  _buildNavItem(icon: Icons.add_circle_outline, label: 'Sell', index: 2),
                  _buildNavItem(icon: Icons.local_mall_outlined, label: 'Orders', index: 3),
                  _buildNavItem(icon: Icons.person_outline, label: 'Profile', index: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(int index) {
    final item = _favoriteItems[index];
    final String oldPrice = item['oldPrice'] as String;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image'] as String,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['brandSize'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: textMuted,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['title'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['condition'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      item['price'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    if (oldPrice.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        oldPrice,
                        style: const TextStyle(
                          fontSize: 12,
                          color: textMuted,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'View item',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 12, color: textDark),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _favoriteItems.removeAt(index);
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.close, size: 13, color: textMuted),
                          SizedBox(width: 2),
                          Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: 12,
                              color: textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _currentBottomNav == index;
    return GestureDetector(
      onTap: () => setState(() => _currentBottomNav = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? textDark : textMuted,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? textDark : textMuted,
            ),
          ),
        ],
      ),
    );
  }
}