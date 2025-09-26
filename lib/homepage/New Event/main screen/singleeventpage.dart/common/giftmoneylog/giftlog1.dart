// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < mobileBreakpoint;
        final isTablet =
            screenWidth >= mobileBreakpoint && screenWidth < tabletBreakpoint;

        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(screenWidth),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(isSmallScreen),
                  SizedBox(height: isSmallScreen ? 6.0 : 12.0),
                  _buildResponsiveTransactionCard(
                    screenWidth: screenWidth,
                    isSmallScreen: isSmallScreen,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isSmallScreen ? 16.0 : 20.0),
                  _buildResponsiveActionButtons(isSmallScreen),
                  SizedBox(height: isSmallScreen ? 16.0 : 20.0),
                  _listOfGifts(screenWidth, isSmallScreen, isTablet),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < mobileBreakpoint) return 16.0;
    if (screenWidth < tabletBreakpoint) return 24.0;
    return 32.0;
  }

  Widget _buildHeaderSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isSmallScreen ? 16.0 : 24.0),
        Text(
          'Gift Transaction Overview',
          style: TextStyle(
            fontSize: isSmallScreen ? 15 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: isSmallScreen ? 4.0 : 8.0),
        Text(
          "Track and manage all gifts received from your guests in one centralized location. "
          "Monitor gift transactions with real-time updates and comprehensive reporting",
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveTransactionCard({
    required double screenWidth,
    required bool isSmallScreen,
    required bool isTablet,
  }) {
    final cardPadding = EdgeInsets.all(isSmallScreen ? 12.0 : 16.0);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmallScreen ? 12.0 : 16.0),
      ),
      child: Container(
        width: double.infinity,
        padding: cardPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSmallScreen ? 12.0 : 16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 8,
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
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
                    size: isSmallScreen ? 18 : 22,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: _buildTransactionInfo(isSmallScreen, isTablet),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 8.0 : 12.0),
            _buildCustomProgressIndicator(
              progressColor: Colors.green.shade600,
              backgroundColor: Colors.grey.shade200,
              height: isSmallScreen ? 8.0 : 10.0,
              progress: widget.items.isEmpty ? 0.0 : 0.8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionInfo(bool isSmallScreen, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: isTablet ? 3 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gift Log",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Total transactions",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11 : 13,
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
                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '₹${_calculateTotalAmount()}',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600,
                        ),
                      ),
                      TextSpan(
                        text: ' / ',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      TextSpan(
                        text: '${widget.items.length}',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.items.length} gifts received',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 9 : 11,
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
    return widget.items.length.toString();
  }

  Widget _buildCustomProgressIndicator({
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
          builder: (context, _) {
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

  Future<void> downloadContainerAsPDF() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Generating PDF...'),
          duration: Duration(seconds: 1),
        ),
      );

      // Load image for PDF
      Uint8List? giftImageBytes;
      bool imageLoaded = false;

      try {
        final ByteData imageData =
            await rootBundle.load('assets/images/gift.jpg');
        giftImageBytes = imageData.buffer.asUint8List();
        imageLoaded = true;
      } catch (e) {
        debugPrint('Error loading gift image for PDF: $e');
      }

      final pdf = pw.Document();
      final now = DateTime.now();
      final dateStr = '${now.day}/${now.month}/${now.year}';

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) =>
              _buildPDFContent(dateStr, imageLoaded, giftImageBytes),
        ),
      );

      final bytes = await pdf.save();
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'gift_log_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(bytes);
      final result = await OpenFilex.open(file.path);

      _showPDFResult(result, fileName, imageLoaded);
    } catch (e) {
      debugPrint('PDF Error: $e');
      _showErrorSnackBar('Error generating PDF: ${e.toString()}');
    }
  }

  List<pw.Widget> _buildPDFContent(
      String dateStr, bool imageLoaded, Uint8List? giftImageBytes) {
    return [
      // Header
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Gift Transaction Log',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Image Status: ${imageLoaded ? "✅ Loaded" : "❌ Failed"}',
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey),
              ),
            ],
          ),
          pw.Text(dateStr, style: const pw.TextStyle(fontSize: 14)),
        ],
      ),

      pw.SizedBox(height: 20),

      // Summary
      _buildPDFSummaryBox(),

      pw.SizedBox(height: 20),

      pw.Text(
        'Gift Details:',
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
      ),

      pw.SizedBox(height: 10),

      // Gift items
      ...widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return _buildPDFGiftItem(index, item, imageLoaded, giftImageBytes);
      }).toList(),
    ];
  }

  pw.Widget _buildPDFSummaryBox() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.blue, width: 1),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Total Gifts Received:',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            '${widget.items.length}',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPDFGiftItem(int index, Map<String, String> item,
      bool imageLoaded, Uint8List? giftImageBytes) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Image
          pw.Container(
            width: 60,
            height: 60,
            margin: const pw.EdgeInsets.only(right: 12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300, width: 1),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: imageLoaded && giftImageBytes != null
                ? pw.ClipRRect(
                    verticalRadius: 7,
                    horizontalRadius: 7,
                    child: pw.Image(
                      pw.MemoryImage(giftImageBytes),
                      fit: pw.BoxFit.cover,
                    ),
                  )
                : pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue50,
                      borderRadius: pw.BorderRadius.circular(7),
                    ),
                    child: pw.Center(
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'GIFT',
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue800,
                            ),
                          ),
                          pw.Text(
                            '${index + 1}',
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          // Content
          pw.Expanded(
            child: _buildPDFGiftContent(index, item),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPDFGiftContent(int index, Map<String, String> item) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '${index + 1}. ${item['name'] ?? 'Unknown Guest'}',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        if ((item['mobileno'] ?? '').isNotEmpty ||
            (item['giftname'] ?? '').isNotEmpty)
          pw.Row(
            children: [
              if ((item['mobileno'] ?? '').isNotEmpty)
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Phone: ${item['mobileno']}',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ),
              if ((item['giftname'] ?? '').isNotEmpty)
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Gift: ${item['giftname']}',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ),
            ],
          ),
        if ((item['address'] ?? '').isNotEmpty) ...[
          pw.SizedBox(height: 3),
          pw.Text(
            'Address: ${item['address']}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ],
        if ((item['forWhom'] ?? '').isNotEmpty ||
            (item['giftType'] ?? '').isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Container(
            padding: const pw.EdgeInsets.all(6),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Row(
              children: [
                if ((item['forWhom'] ?? '').isNotEmpty)
                  pw.Expanded(
                    child: pw.Text(
                      'For: ${item['forWhom']}',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                if ((item['giftType'] ?? '').isNotEmpty)
                  pw.Expanded(
                    child: pw.Text(
                      'Type: ${item['giftType']}',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _showPDFResult(OpenResult result, String fileName, bool imageLoaded) {
    if (result.type == ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(imageLoaded
              ? 'PDF with images created successfully!'
              : 'PDF created (image not loaded)'),
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildResponsiveActionButtons(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 3,
              padding: EdgeInsets.symmetric(
                vertical: isSmallScreen ? 12.0 : 16.0,
                horizontal: isSmallScreen ? 16.0 : 20.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: widget.items.isEmpty ? null : downloadContainerAsPDF,
            icon: Icon(
              Icons.file_download_outlined,
              size: isSmallScreen ? 18.0 : 22.0,
              color: widget.items.isEmpty ? Colors.grey : Colors.black,
            ),
            label: Text(
              "Download PDF",
              style: TextStyle(
                fontSize: isSmallScreen ? 12.0 : 14.0,
                color: widget.items.isEmpty ? Colors.grey : AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 20),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 3,
              padding: EdgeInsets.symmetric(
                vertical: isSmallScreen ? 12.0 : 16.0,
                horizontal: isSmallScreen ? 16.0 : 20.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: widget.onAddPressed,
            icon: Icon(
              Icons.add_rounded,
              size: isSmallScreen ? 18.0 : 22.0,
            ),
            label: Text(
              "Add Gift",
              style: TextStyle(
                fontSize: isSmallScreen ? 12.0 : 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Image popup functionality
  void _showImagePopup(BuildContext context, String imagePath, int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              // Backdrop
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              // Image content
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
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                  color: Colors.grey.shade400,
                                ),
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
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // Close button
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
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              // Info overlay
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
                  child: Text(
                    'Gift #${index + 1} • Pinch to zoom • Tap outside to close',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
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

  Widget _listOfGifts(double screenWidth, bool isSmallScreen, bool isTablet) {
    if (widget.items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 32.0 : 48.0),
          child: Column(
            children: [
              Icon(
                Icons.card_giftcard_outlined,
                size: isSmallScreen ? 48 : 64,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
              Text(
                "No gift data available",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              Text(
                "Start adding gifts to see them here",
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListHeader(isSmallScreen),
          SizedBox(height: isSmallScreen ? 12 : 16),
          _buildSummaryCard(isSmallScreen),
          SizedBox(height: isSmallScreen ? 12 : 16),
          _buildGiftList(screenWidth, isSmallScreen, isTablet),
        ],
      ),
    );
  }

  Widget _buildListHeader(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Gift Transaction Log",
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          DateTime.now().toString().split(' ')[0],
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Gifts Received:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
          Text(
            "${widget.items.length}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 15 : 16,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftList(double screenWidth, bool isSmallScreen, bool isTablet) {
    // Calculate number of columns based on screen width
    int crossAxisCount = 1;
    if (screenWidth > tabletBreakpoint) {
      crossAxisCount = 2;
    } else if (screenWidth > mobileBreakpoint) {
      crossAxisCount = 1;
    }

    if (crossAxisCount > 1) {
      // Grid layout for larger screens
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return _buildGiftCard(index, widget.items[index], isSmallScreen);
        },
      );
    } else {
      // List layout for mobile
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => SizedBox(height: isSmallScreen ? 6 : 8),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return _buildGiftCard(index, widget.items[index], isSmallScreen);
        },
      );
    }
  }

  Widget _buildGiftCard(
      int index, Map<String, String> item, bool isSmallScreen) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 50)),
      curve: Curves.easeOutBack,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Image + 3 Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGiftImage(index, isSmallScreen),
                  SizedBox(width: isSmallScreen ? 10 : 12),
                  Expanded(
                    child: _buildMainDetails(index, item, isSmallScreen),
                  ),
                ],
              ),

              // Row 2: Gift Details (if available) - Full width without left margin
              if (_hasGiftDetails(item)) ...[
                SizedBox(height: isSmallScreen ? 8 : 12),
                _buildGiftDetailsSection(item, isSmallScreen),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGiftImage(int index, bool isSmallScreen) {
    final imageSize = isSmallScreen ? 50.0 : 60.0;

    return Hero(
      tag: 'gift_image_$index',
      child: GestureDetector(
        onTap: () => _showImagePopup(context, 'assets/images/gift.jpg', index),
        child: Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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
                  width: imageSize,
                  height: imageSize,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildImageFallback(index, imageSize, isSmallScreen);
                  },
                ),
                // Tap indicator overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                        size: 16,
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

  Widget _buildImageFallback(int index, double size, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade100,
            Colors.blue.shade200,
          ],
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.card_giftcard_rounded,
            color: Colors.blue.shade600,
            size: isSmallScreen ? 16 : 20,
          ),
          SizedBox(height: isSmallScreen ? 2 : 4),
          Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade600,
            ),
          ),
        ],
      ),
    );
  }

// Main details (Name, Phone, Address) - Right side of image
  Widget _buildMainDetails(
      int index, Map<String, String> item, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Name
        Text(
          '${index + 1}. ${item['name'] ?? 'Unknown Guest'}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 14 : 16,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: isSmallScreen ? 4 : 6),

        // 2. Phone Number
        if ((item['mobileno'] ?? '').isNotEmpty) ...[
          Row(
            children: [
              Icon(
                Icons.phone,
                size: isSmallScreen ? 12 : 14,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item['mobileno']!,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 3 : 4),
        ],

        // 3. Address
        if ((item['address'] ?? '').isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                size: isSmallScreen ? 12 : 14,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item['address']!,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 13,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

// Gift Details Section - Full width, no left margin
  Widget _buildGiftDetailsSection(
      Map<String, String> item, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
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
              Icon(
                Icons.card_giftcard,
                size: isSmallScreen ? 14 : 16,
                color: Colors.green.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                'Gift Details',
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),

          SizedBox(height: isSmallScreen ? 6 : 8),

          // Gift Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((item['giftname'] ?? '').isNotEmpty)
                _buildFullWidthDetailRow(
                  Icons.redeem,
                  'Gift Name',
                  item['giftname']!,
                  Colors.green.shade600,
                  isSmallScreen,
                ),
              if ((item['forWhom'] ?? '').isNotEmpty) ...[
                if ((item['giftname'] ?? '').isNotEmpty)
                  SizedBox(height: isSmallScreen ? 4 : 6),
                _buildFullWidthDetailRow(
                  Icons.person,
                  'For',
                  item['forWhom']!,
                  Colors.green.shade600,
                  isSmallScreen,
                ),
              ],
              if ((item['giftType'] ?? '').isNotEmpty) ...[
                if ((item['giftname'] ?? '').isNotEmpty ||
                    (item['forWhom'] ?? '').isNotEmpty)
                  SizedBox(height: isSmallScreen ? 4 : 6),
                _buildFullWidthDetailRow(
                  Icons.category,
                  'Type',
                  item['giftType']!,
                  Colors.green.shade600,
                  isSmallScreen,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFullWidthDetailRow(
    IconData icon,
    String label,
    String value,
    Color color,
    bool isSmallScreen,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: isSmallScreen ? 12 : 14,
          color: color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: isSmallScreen ? 11 : 12,
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
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  bool _hasGiftDetails(Map<String, String> item) {
    return (item['giftname'] ?? '').isNotEmpty ||
        (item['forWhom'] ?? '').isNotEmpty ||
        (item['giftType'] ?? '').isNotEmpty;
  }
}
