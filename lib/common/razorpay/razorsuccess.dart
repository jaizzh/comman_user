import 'dart:ui';
import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

Future<void> showPaymentSuccessDialog(
  BuildContext context, {
  required int amountPaise, // e.g., 129900
  String? orderId, // optional
  String title = "Payment Successful",
  Duration autoCloseAfter = const Duration(milliseconds: 7500),
}) async {
  final amountRupees = (amountPaise / 100).toStringAsFixed(2);

  // show the dialog
  showGeneralDialog(
    context: context,
    barrierLabel: 'Payment Success',
    barrierDismissible: true,
    // barrierColor: Colors.black.withOpacity(0.35),
    transitionDuration: const Duration(milliseconds: 3000),
    pageBuilder: (_, __, ___) {
      return const SizedBox.shrink(); // required but unused
    },
    transitionBuilder: (ctx, anim, __, ___) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: .95, end: 1).animate(curved),
          child: Center(
            child: _SuccessCard(
              amountRupees: amountRupees,
              orderId: orderId,
              title: title,
            ),
          ),
        ),
      );
    },
  );

  // auto close after a short delay (optional)
  if (autoCloseAfter.inMilliseconds > 0) {
    await Future.delayed(autoCloseAfter);
    if (context.mounted) Navigator.of(context, rootNavigator: true).maybePop();
  }
}

class _SuccessCard extends StatelessWidget {
  final String amountRupees;
  final String? orderId;
  final String title;

  const _SuccessCard({
    required this.amountRupees,
    required this.orderId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cardWidth = w > 420 ? 380.0 : (w * 0.9);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // glass + border glow
            color: Colors.white.withOpacity(0.85),
            //   border: Border.all(color: const Color(0xFFBFA054).withOpacity(.35), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 28,
                offset: Offset(0, 18),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF9F6EF), // paper
                Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // gradient header
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFEDD498), Color(0xFFBFA054)],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: .3,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .maybePop(),
                        icon: const Icon(Icons.close_rounded,
                            size: 18, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "New Event Created",
                      style: GoogleFonts.sahitya(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttoncolor),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // success animation
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: SizedBox(
                  height: 130,
                  child: _SuccessAnimation(),
                ),
              ),

              const SizedBox(height: 8),

              // amount + badge
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "You paid ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: "₹$amountRupees",
                            style: const TextStyle(
                                color: Color(0xFF9A2143),
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (orderId != null && orderId!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827).withOpacity(.06),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color: const Color(0xFFBFA054).withOpacity(.5),
                              width: 1),
                        ),
                        child: Text(
                          "Order: $orderId",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .2,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // CTA row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    MainPage())), //Navigator.of(context, rootNavigator: true).maybePop(),
                        icon: const Icon(Icons.close_rounded, size: 18),
                        label: const Text("Close"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF111827),
                          side:
                              BorderSide(color: Colors.black.withOpacity(.15)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    MainPage())), //  => Navigator.of(context, rootNavigator: true).maybePop(),
                        icon: const Icon(Icons.verified_rounded,
                            size: 18, color: Colors.white),
                        label: const Text("Great!"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9A2143),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // prefer Lottie; falls back to a static/gif if asset missing
    return Stack(
      alignment: Alignment.center,
      children: [
        // soft flare (optional)
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.09,
              child: Image.asset(
                'assets/images/chat2.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
        ),
        // lottie success
        Lottie.asset(
          'assets/images/Success.json',
          repeat: false,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return Image.asset(
              'assets/images/chat1.png',
              fit: BoxFit.contain,
            );
          },
        ),
      ],
    );
  }
}
