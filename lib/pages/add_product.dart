import 'dart:ui';
import 'package:flutter/material.dart';
import 'order_history_tracking.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // Color palette dari Figma
  static const Color bgColor = Color(0xFFF8F6F0);
  static const Color primaryGreen = Color(0xFF2F3E33);
  static const Color addPhotoBg = Color(0xFFE2EBE0);
  static const Color addPhotoBorder = Color(0xFFB8C8B5);
  static const Color warningBg = Color(0xFFFBF0E7);
  static const Color warningText = Color(0xFFC86A4B);
  static const Color fieldBorderColor = Color(0xFFE5E2D9);
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color textMuted = Color(0xFF8E8E93);

  // Form controllers & state
  final _titleController = TextEditingController(text: 'Olive Linen Work Jacket');
  final _brandController = TextEditingController(text: 'MUJI');
  String? _selectedCategory = 'Outerwear';
  final _priceController = TextEditingController(text: '185.000');
  final _descController = TextEditingController(
    text: 'Tiny thread pull near left cuff; light fading at elbows. No stains, odors, or missing buttons.',
  );

  String _selectedCondition = '90%';
  final List<String> _conditions = ['70%', '80%', '90%', 'Like New'];

  final List<String> _photos = [
    'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
    'https://images.unsplash.com/photo-1544441893-675973e31985?w=500',
    'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500',
  ];

  // Simulasi tambah foto untuk eksplorasi ListView.builder (M06)
  void _addSamplePhoto() {
    if (_photos.length < 6) {
      setState(() {
        _photos.add('https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // M07: MediaQuery untuk ukuran layar & responsivitas
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar
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
                    'List an Item',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.more_horiz, color: textDark, size: 22),
                  ),
                ],
              ),
            ),

            // Listing content dengan M07 LayoutBuilder (Adaptive Constraint)
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Membatasi lebar form di tablet/desktop agar proporsional (M07)
                  final double horizontalPad =
                      constraints.maxWidth > 650 ? screenWidth * 0.15 : 20.0;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photos header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Photos',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                              ),
                            ),
                            Text(
                              '${_photos.length} / 6 uploaded',
                              style: const TextStyle(fontSize: 13, color: textMuted),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // M06: Horizontal ListView.builder untuk koleksi foto dinamis
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _photos.length + 1, // +1 untuk tombol Add Photo
                            itemBuilder: (context, index) {
                              // Index 0: Tombol Add Photo dengan Custom Dashed Border
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: _addSamplePhoto,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: CustomPaint(
                                      painter: _DashedBorderPainter(
                                        color: addPhotoBorder,
                                        strokeWidth: 1.5,
                                        radius: 16,
                                      ),
                                      child: Container(
                                        width: 95,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: addPhotoBg,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt_outlined,
                                                color: primaryGreen, size: 26),
                                            SizedBox(height: 6),
                                            Text(
                                              'Add Photo',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: primaryGreen,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // Index berikutnya: Foto yang sudah diunggah
                              final int photoIdx = index - 1;
                              final String url = _photos[photoIdx];
                              return Container(
                                width: 95,
                                height: 120,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // M06: Stack + Positioned untuk badge COVER & tombol hapus
                                child: Stack(
                                  children: [
                                    if (photoIdx == 0)
                                      Positioned(
                                        bottom: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: primaryGreen.withValues(alpha: 0.85),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            'COVER',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (_photos.length > 1)
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: GestureDetector(
                                          onTap: () => setState(() => _photos.removeAt(photoIdx)),
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(alpha: 0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.close,
                                                size: 12, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Show front, back, label, and every flaw in bright natural light.',
                          style: TextStyle(fontSize: 12, color: textMuted),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        _buildLabel('Title'),
                        _buildInputField(controller: _titleController),
                        const SizedBox(height: 14),

                        // Brand & Category (M06: Row + Expanded)
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Brand'),
                                  _buildInputField(controller: _brandController),
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Category'),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: fieldBorderColor),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedCategory,
                                        isExpanded: true,
                                        icon: const Icon(Icons.keyboard_arrow_down, color: textMuted),
                                        items: ['Outerwear', 'Shirts', 'Pants', 'Shoes']
                                            .map((cat) => DropdownMenuItem(
                                                  value: cat,
                                                  child: Text(
                                                    cat,
                                                    style: const TextStyle(
                                                        fontSize: 14, color: textDark),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (val) => setState(() => _selectedCategory = val),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Price
                        _buildLabel('Price'),
                        _buildInputField(
                          controller: _priceController,
                          suffixText: 'IDR',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 14),

                        // Item Condition
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLabel('Item Condition'),
                            Text(
                              '$_selectedCondition Good',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // M06 & M07: Expanded mencegah RenderFlex overflow pada chip kondisi
                        Row(
                          children: _conditions.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String cond = entry.value;
                            bool isSelected = _selectedCondition == cond;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedCondition = cond),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: idx == _conditions.length - 1 ? 0 : 8),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryGreen : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: isSelected ? primaryGreen : fieldBorderColor,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      cond,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.white : textDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 14),

                        // Warning note
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: warningBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.error_outline, color: warningText, size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Add honest flaws/minus notes to build buyer trust.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Description & Flaws
                        _buildLabel('Description & Flaws'),
                        _buildInputField(
                          controller: _descController,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Publish action (Sticky Bottom Bar)
            Container(
              height: 80,
              padding: const EdgeInsets.only(top: 10, right: 20, bottom: 18, left: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFDDDCD5), width: 1.0),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistoryAndTracking(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Publish Listing',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? suffixText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: textDark),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        suffixIcon: suffixText != null
            ? Padding(
                padding: const EdgeInsets.only(right: 14, top: 12),
                child: Text(
                  suffixText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textMuted,
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: fieldBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: fieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 1.5),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.radius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    double distance = 0.0;
    for (final PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + 6),
          Offset.zero,
        );
        distance += 10;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}