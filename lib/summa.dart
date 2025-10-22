// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';

import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// GiftLogger
/// - Responsive across mobile (<600), tablet (600-1024), desktop (>=1024)
/// - Smooth progress animation
/// - Grid/List switch based on width
/// - Robust PDF export with summary + table (auto-pagination)
class GiftLogger extends StatefulWidget {
  final List<Map<String, String>> items;
  final VoidCallback onAddPressed;

  const GiftLogger({
    super.key,
    required this.items,
    required this.onAddPressed,
  });

  @override
  State<GiftLogger> createState() => _GiftLoggerState();
}

class _GiftLoggerState extends State<GiftLogger> with TickerProviderStateMixin {
  late final AnimationController _progressController;

  // Responsive breakpoints
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;

  @override
  void initState() {
    super.initState();
    _progressController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // remove this line if you want to inherit page theme background
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Gift Transaction Log'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          final screenWidth = constraints.maxWidth;
          final isSmall = screenWidth < _mobileBreakpoint;
          final isTablet = screenWidth >= _mobileBreakpoint &&
              screenWidth < _tabletBreakpoint;

          return SafeArea(
            top: false, // appBar already handles status bar
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: _hPad(screenWidth)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(isSmall),
                  SizedBox(height: isSmall ? 8 : 12),
                  _transactionCard(
                    screenWidth: screenWidth,
                    isSmall: isSmall,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isSmall ? 16 : 20),
                  _actionButtons(isSmall),
                  SizedBox(height: isSmall ? 16 : 20),
                  _giftListBlock(screenWidth, isSmall),
                  SizedBox(height: isSmall ? 24 : 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- Helpers ----------

  double _hPad(double w) {
    if (w < _mobileBreakpoint) return 16.0;
    if (w < _tabletBreakpoint) return 24.0;
    return 32.0;
  }

  String _today() {
    final now = DateTime.now();
    final d = now.day.toString().padLeft(2, '0');
    final m = now.month.toString().padLeft(2, '0');
    final y = now.year;
    return '$y-$m-$d';
  }

  // ---------- UI Sections ----------

  Widget _header(bool isSmall) {
    return Padding(
      padding: EdgeInsets.only(top: isSmall ? 16 : 24, bottom: isSmall ? 4 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gift Transaction Overview',
            style: TextStyle(
              fontSize: isSmall ? 16 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isSmall ? 4 : 8),
          Text(
            'Track and manage all gifts received from your guests in one place. '
            'Monitor transactions with real-time updates and export reports.',
            style: TextStyle(
              fontSize: isSmall ? 12 : 14,
              color: Colors.black54,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionCard({
    required double screenWidth,
    required bool isSmall,
    required bool isTablet,
  }) {
    final pad = EdgeInsets.all(isSmall ? 12 : 16);
    final totalCount = widget.items.length;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmall ? 12 : 16),
      ),
      child: Container(
        width: double.infinity,
        padding: pad,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSmall ? 12 : 16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 8,
              color: Colors.black.withOpacity(0.07),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isSmall ? 8 : 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.card_giftcard_rounded,
                    color: AppColors.primary,
                    size: isSmall ? 18 : 22,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                    child: _transactionInfo(isSmall, isTablet, totalCount)),
              ],
            ),
            SizedBox(height: isSmall ? 10 : 12),
            _animatedProgressBar(
              progressColor: Colors.green.shade600,
              backgroundColor: Colors.grey.shade200,
              height: isSmall ? 8 : 10,
              progress: totalCount == 0
                  ? 0.0
                  : 0.8, // replace with (current/target) if needed
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionInfo(bool isSmall, bool isTablet, int totalCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Subtitle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: isTablet ? 3 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gift Log',
                    style: TextStyle(
                      fontSize: isSmall ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Total transactions',
                    style: TextStyle(
                      fontSize: isSmall ? 11 : 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // You can change this to sum of amounts if you add monetary fields later.
                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '₹${_calculateTotalAmount()}',
                        style: TextStyle(
                          fontSize: isSmall ? 14 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      TextSpan(
                        text: '  •  ',
                        style: TextStyle(
                          fontSize: isSmall ? 12 : 14,
                          color: Colors.black45,
                        ),
                      ),
                      TextSpan(
                        text: '$totalCount gifts',
                        style: TextStyle(
                          fontSize: isSmall ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalCount gifts received',
                  style: TextStyle(
                    fontSize: isSmall ? 10 : 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _calculateTotalAmount() {
    // Placeholder: returns count; replace with real sum if you add an "amount" key.
    return widget.items.length.toString();
  }

  Widget _animatedProgressBar({
    required Color progressColor,
    required Color backgroundColor,
    required double height,
    required double progress,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        color: backgroundColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: AnimatedBuilder(
          animation: _progressController,
          builder: (_, __) {
            return LinearProgressIndicator(
              value: progress * _progressController.value,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              backgroundColor: Colors.transparent,
              minHeight: height,
            );
          },
        ),
      ),
    );
  }

  Widget _actionButtons(bool isSmall) {
    final isDisabled = widget.items.isEmpty;

    return Row(
      children: [
        // Download PDF
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              disabledBackgroundColor: Colors.white,
              elevation: 3,
              padding: EdgeInsets.symmetric(
                vertical: isSmall ? 12 : 16,
                horizontal: isSmall ? 16 : 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isDisabled ? Colors.grey.shade300 : Colors.black12,
                ),
              ),
            ),
            onPressed: isDisabled ? null : _downloadPdf,
            icon: Icon(
              Icons.file_download_outlined,
              size: isSmall ? 18 : 22,
              color: isDisabled ? Colors.grey : Colors.black87,
            ),
            label: Text(
              'Download PDF',
              style: TextStyle(
                fontSize: isSmall ? 12 : 14,
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.grey : AppColors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: isSmall ? 12 : 20),
        // Add Gift
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 3,
              padding: EdgeInsets.symmetric(
                vertical: isSmall ? 12 : 16,
                horizontal: isSmall ? 16 : 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: widget.onAddPressed,
            icon: Icon(Icons.add_rounded, size: isSmall ? 18 : 22),
            label: Text(
              'Add Gift',
              style: TextStyle(
                fontSize: isSmall ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _giftListBlock(double screenWidth, bool isSmall) {
    if (widget.items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isSmall ? 32 : 48),
          child: Column(
            children: [
              Icon(Icons.card_giftcard_outlined,
                  size: isSmall ? 52 : 64, color: Colors.grey.shade400),
              SizedBox(height: isSmall ? 14 : 20),
              Text(
                'No gift data available',
                style: TextStyle(
                  fontSize: isSmall ? 16 : 18,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: isSmall ? 8 : 10),
              Text(
                'Start adding gifts to see them here',
                style: TextStyle(
                  fontSize: isSmall ? 12 : 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gift Transaction Log',
                style: TextStyle(
                  fontSize: isSmall ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _today(),
                style: TextStyle(
                  fontSize: isSmall ? 12 : 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 12 : 16),
          // Summary
          Container(
            padding: EdgeInsets.all(isSmall ? 10 : 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Gifts Received:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmall ? 13 : 14,
                  ),
                ),
                Text(
                  '${widget.items.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmall ? 15 : 16,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isSmall ? 12 : 16),
          // List/Grid
          _responsiveList(screenWidth, isSmall),
        ],
      ),
    );
  }

  Widget _responsiveList(double screenWidth, bool isSmall) {
    // Two columns on desktop; one on mobile/tablet
    final useGrid = screenWidth >= _tabletBreakpoint;

    if (useGrid) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.6,
        ),
        itemCount: widget.items.length,
        itemBuilder: (_, i) => _giftCard(i, widget.items[i], isSmall),
      );
    }

    // List for mobile & tablet
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(height: isSmall ? 8 : 10),
      itemCount: widget.items.length,
      itemBuilder: (_, i) => _giftCard(i, widget.items[i], isSmall),
    );
  }

  Widget _giftCard(int index, Map<String, String> item, bool isSmall) {
    final hasDetails = _hasGiftDetails(item);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 40)),
      curve: Curves.easeOutBack,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(isSmall ? 10 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Image + main details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _giftImage(index, isSmall),
                  SizedBox(width: isSmall ? 10 : 12),
                  Expanded(child: _mainDetails(index, item, isSmall)),
                ],
              ),
              if (hasDetails) ...[
                SizedBox(height: isSmall ? 8 : 12),
                _giftDetails(item, isSmall),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _giftImage(int index, bool isSmall) {
    final size = isSmall ? 54.0 : 64.0;

    return Hero(
      tag: 'gift_image_$index',
      child: GestureDetector(
        onTap: () => _showImagePopup(context, 'assets/images/gift.jpg', index),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/gift.jpg',
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  errorBuilder: (_, __, ___) =>
                      _imageFallback(index, size, isSmall),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.black.withOpacity(0.08),
                      ),
                      child: const Center(
                        child:
                            Icon(Icons.zoom_in, color: Colors.white, size: 16),
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

  Widget _imageFallback(int index, double size, bool isSmall) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard_rounded,
              color: Colors.blue.shade700, size: isSmall ? 18 : 22),
          SizedBox(height: isSmall ? 2 : 4),
          Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: isSmall ? 10 : 12,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainDetails(int index, Map<String, String> item, bool isSmall) {
    final name = (item['name'] ?? '').trim();
    final phone = (item['mobileno'] ?? '').trim();
    final address = (item['address'] ?? '').trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${index + 1}. ${name.isEmpty ? 'Unknown Guest' : name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmall ? 14 : 16,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: isSmall ? 4 : 6),
        if (phone.isNotEmpty) ...[
          Row(
            children: [
              Icon(Icons.phone,
                  size: isSmall ? 12 : 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  phone,
                  style: TextStyle(fontSize: isSmall ? 12 : 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 3 : 4),
        ],
        if (address.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on,
                  size: isSmall ? 12 : 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: isSmall ? 11 : 13,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _giftDetails(Map<String, String> item, bool isSmall) {
    final gift = (item['giftname'] ?? '').trim();
    final forWhom = (item['forWhom'] ?? '').trim();
    final giftType = (item['giftType'] ?? '').trim();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmall ? 8 : 10),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.card_giftcard,
                  size: isSmall ? 14 : 16, color: Colors.green.shade700),
              const SizedBox(width: 6),
              Text(
                'Gift Details',
                style: TextStyle(
                  fontSize: isSmall ? 12 : 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 6 : 8),
          // Content
          if (gift.isNotEmpty)
            _detailLine(
              icon: Icons.redeem,
              label: 'Gift Name',
              value: gift,
              color: Colors.green.shade700,
              isSmall: isSmall,
            ),
          if (forWhom.isNotEmpty) ...[
            if (gift.isNotEmpty) SizedBox(height: isSmall ? 4 : 6),
            _detailLine(
              icon: Icons.person,
              label: 'For',
              value: forWhom,
              color: Colors.green.shade700,
              isSmall: isSmall,
            ),
          ],
          if (giftType.isNotEmpty) ...[
            if (gift.isNotEmpty || forWhom.isNotEmpty)
              SizedBox(height: isSmall ? 4 : 6),
            _detailLine(
              icon: Icons.category,
              label: 'Type',
              value: giftType,
              color: Colors.green.shade700,
              isSmall: isSmall,
            ),
          ],
        ],
      ),
    );
  }

  Widget _detailLine({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isSmall,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: isSmall ? 12 : 14, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                fontSize: isSmall ? 11 : 12,
                color: Colors.black87,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _hasGiftDetails(Map<String, String> item) {
    return ((item['giftname'] ?? '').trim().isNotEmpty) ||
        ((item['forWhom'] ?? '').trim().isNotEmpty) ||
        ((item['giftType'] ?? '').trim().isNotEmpty);
  }

  // ---------- Image Popup ----------

  void _showImagePopup(BuildContext context, String imagePath, int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const SizedBox.expand(),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 3.0,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_not_supported,
                                  size: 60, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                'Image not found',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Gift #${index + 1}',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Pinch to zoom • Tap outside to close',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------- PDF (Summary + Details Table) ----------

  Future<void> _downloadPdf() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Generating PDF...'), duration: Duration(seconds: 1)),
      );

      // Attempt to load an image; it's optional
      Uint8List? giftImageBytes;
      var imageLoaded = false;
      try {
        final bd = await rootBundle.load('assets/images/gift.jpg');
        giftImageBytes = bd.buffer.asUint8List();
        imageLoaded = true;
      } catch (_) {
        imageLoaded = false;
      }

      final pdf = pw.Document();
      final dateStr = _today();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(28),
          build: (_) => [
            // Header
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Gift Transaction Log',
                        style: pw.TextStyle(
                          fontSize: 22,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      'Generated on $dateStr',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Image Status: ${imageLoaded ? 'Loaded' : 'Not Found'}',
                      style: pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
                if (imageLoaded && giftImageBytes != null)
                  pw.Container(
                    width: 48,
                    height: 48,
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(6),
                      border: pw.Border.all(color: PdfColors.grey300),
                    ),
                    child: pw.ClipRRect(
                      horizontalRadius: 6,
                      verticalRadius: 6,
                      child: pw.Image(pw.MemoryImage(giftImageBytes),
                          fit: pw.BoxFit.cover),
                    ),
                  ),
              ],
            ),
            pw.SizedBox(height: 16),

            // Summary Box
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.blue),
                color: PdfColors.blue50,
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Gifts Received:',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text('${widget.items.length}',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // Details Table
            _pdfDetailsTable(widget.items),
          ],
        ),
      );

      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'gift_log_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);

      final result = await OpenFilex.open(file.path);
      _showPdfSnack(result, fileName, imageLoaded);
    } catch (e) {
      _errorSnack('Error generating PDF: $e');
    }
  }

  pw.Widget _pdfDetailsTable(List<Map<String, String>> items) {
    // Table headers
    final headers = [
      'S.No',
      'Name',
      'Phone',
      'Gift',
      'For',
      'Type',
      'Address',
    ];

    // Table rows
    final dataRows = <List<String>>[];
    for (var i = 0; i < items.length; i++) {
      final m = items[i];
      dataRows.add([
        '${i + 1}',
        (m['name'] ?? '').trim().isEmpty ? 'Unknown Guest' : (m['name'] ?? ''),
        (m['mobileno'] ?? '').trim(),
        (m['giftname'] ?? '').trim(),
        (m['forWhom'] ?? '').trim(),
        (m['giftType'] ?? '').trim(),
        (m['address'] ?? '').trim(),
      ]);
    }

    return pw.Table.fromTextArray(
      headers: headers,
      data: dataRows,
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blue700),
      cellAlignment: pw.Alignment.centerLeft,
      headerAlignment: pw.Alignment.centerLeft,
      cellStyle: const pw.TextStyle(fontSize: 9),
      headerHeight: 24,
      cellHeight: 22,
      border: pw.TableBorder(
        horizontalInside: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
        verticalInside: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
        top: pw.BorderSide(color: PdfColors.grey300, width: 0.7),
        bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.7),
        left: pw.BorderSide(color: PdfColors.grey300, width: 0.7),
        right: pw.BorderSide(color: PdfColors.grey300, width: 0.7),
      ),
      columnWidths: const {
        0: pw.FixedColumnWidth(34),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(2),
        3: pw.FlexColumnWidth(2),
        4: pw.FlexColumnWidth(1.6),
        5: pw.FlexColumnWidth(1.6),
        6: pw.FlexColumnWidth(3),
      },
      oddRowDecoration:
          const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF8FAFF)),
    );
  }

  void _showPdfSnack(OpenResult result, String fileName, bool imageLoaded) {
    if (result.type == ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(imageLoaded
              ? 'PDF (with image) created successfully!'
              : 'PDF created successfully (image not found)'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved as: $fileName'),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _errorSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
