import 'package:flutter/material.dart';
import 'favorites.dart';

class OrderHistoryAndTracking extends StatefulWidget {
  const OrderHistoryAndTracking({super.key});

  @override
  State<OrderHistoryAndTracking> createState() =>
      _OrderHistoryAndTrackingState();
}

class _OrderHistoryAndTrackingState extends State<OrderHistoryAndTracking> {
  // Palet Warna dari Figma
  static const Color bgColor = Color(0xFFF8F6F0);
  static const Color primaryGreen = Color(0xFF2F3E33);
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color tabBg = Color(0xFFEBE8DF);
  static const Color badgeGreenBg = Color(0xFFE2EBE0);
  static const Color badgeGreenText = Color(0xFF3F6244);
  static const Color bottomBarBorder = Color(0xFFDDDCD5);

  int _selectedTab = 0; // 0: Buyer, 1: Seller
  int _currentBottomNav = 3; // Selected index "Orders"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar (Fixed 44px dari Figma)
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
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

            // Orders Content (Padding: Top 8, Right 20, Bottom 12, Left 20, Gap 14)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 20,
                  bottom: 12,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Title & Back Button & Favorite Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 36,
                                height: 36,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.chevron_left, color: textDark, size: 22),
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Orders',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: textDark,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Track every piece, from closet to closet.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        // IKON FAVORIT DENGAN NAVIGASI KE FAVORITES
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Favorites(),
                              ),
                            );
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: textMuted.withOpacity(0.3)),
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              size: 18,
                              color: textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Buyer / Seller Tab Switcher
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: tabBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTab = 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _selectedTab == 0 ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Buyer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: _selectedTab == 0 ? textDark : textMuted,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTab = 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _selectedTab == 1 ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Seller',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: _selectedTab == 1 ? textDark : textMuted,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Active Tracking Card (In Transit)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: primaryGreen.withOpacity(0.3), width: 1.5),
                      ),
                      child: Column(
                        children: [
                          // Item Details & Status
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'ORDER #TM10281',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: textMuted,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Olive Linen Work Jacket',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textDark,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Rp 203.000 total',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: badgeGreenBg,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'IN TRANSIT',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: badgeGreenText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Shipping Info Sub-card
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: primaryGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.local_shipping_outlined,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'J&T Regular • JP0129847612',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: textDark,
                                        ),
                                      ),
                                      Text(
                                        'Estimated Oct 3–4 • South Jakarta Hub',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.copy_outlined, size: 16, color: textMuted),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Timeline Tracking Progress
                          _buildTimelineStep(
                            title: 'Packed',
                            subtitle: 'Seller packed your item',
                            time: 'Oct 1 • 10:24',
                            isCompleted: true,
                            isLast: false,
                          ),
                          _buildTimelineStep(
                            title: 'Shipped',
                            subtitle: 'J&T picked up the parcel',
                            time: 'Oct 1 • 17:40',
                            isCompleted: true,
                            isLast: false,
                          ),
                          _buildTimelineStep(
                            title: 'Delivered',
                            subtitle: 'Estimated arrival',
                            time: 'Oct 3–4',
                            isCompleted: false,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Order History Section
                    const Text(
                      'Order History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Past Order Card
                    Container(
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
                              'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=500',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pleated Midi Skirt',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textDark,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Delivered Sep 18 • Rp 138.000',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'DELIVERED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: badgeGreenText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
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

  // Widget Pembantu Timeline
  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required String time,
    required bool isCompleted,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? primaryGreen : Colors.white,
                border: Border.all(
                  color: isCompleted ? primaryGreen : textMuted.withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: isCompleted ? primaryGreen : textMuted.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? textDark : textMuted,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: isCompleted ? textMuted : textMuted.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: textMuted),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Pembantu Bottom Navigation
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _currentBottomNav == index;
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          // Tab Sell diklik -> kembali ke Add Product
          Navigator.pop(context);
        } else if (index == 4) {
          // Tab Profile diklik -> buka Favorites
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Favorites(),
            ),
          );
        } else {
          setState(() => _currentBottomNav = index);
        }
      },
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