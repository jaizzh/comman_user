import 'dart:async';
import 'package:flutter/material.dart';

/// Drop-in promo carousel with 6 items, auto-scroll to the right every [interval].
class SixPromoCarousel extends StatefulWidget {
  const SixPromoCarousel({
    super.key,
    required this.images, // 6 items expected (asset paths or URLs)
    this.interval = const Duration(seconds: 6),
    this.activeColor = const Color(0xFF2F80ED),
    this.inactiveColor = const Color(0xFFDDDDDD),
    this.cardHeightFactor = 0.375, // 37.5% of screen height
    this.viewportFraction = 0.92,  // little peek left/right
    this.borderRadius = 12.0,
  });

  final List<String> images;
  final Duration interval;
  final Color activeColor;
  final Color inactiveColor;
  final double cardHeightFactor;
  final double viewportFraction;
  final double borderRadius;

  @override
  State<SixPromoCarousel> createState() => _SixPromoCarouselState();
}

class _SixPromoCarouselState extends State<SixPromoCarousel> {
  late final PageController _pageCtrl;
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(viewportFraction: widget.viewportFraction);
    _startAuto();
  }

  void _startAuto() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!_pageCtrl.hasClients || widget.images.isEmpty) return;
      final next = (_current + 1) % widget.images.length;
      _pageCtrl.animateToPage(
        next,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pauseAuto() => _timer?.cancel();

  @override
  void dispose() {
    _timer?.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.images.length == 6,
        'SixPromoCarousel expects exactly 6 images.');

  //  final h = MediaQuery.of(context).size.height * widget.cardHeightFactor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10.0,),
        // Banner area
        GestureDetector(
          onPanDown: (_) => _pauseAuto(), // pause while user drags
          onPanEnd: (_) => _startAuto(),  // resume when released
          child: SizedBox(
            height:  MediaQuery.of(context).size.height * 0.225,
            child: PageView.builder(
              controller: _pageCtrl,
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (_, i) => _promoCard(
                context,
                widget.images[i],
                widget.borderRadius,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        // 6 tiny containers (indicators) — active one expands + changes color
       Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(widget.images.length, (i) {
    final bool active = i == _current;

    return GestureDetector(
      onTap: () {
        _pauseAuto();
        _pageCtrl.animateToPage(
          i,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAuto();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 6,
        width: active ? 25.0 : 8.0,               // 👈 active bigger
        margin: EdgeInsets.only(
          right: i == widget.images.length - 1 ? 0 : 6,
        ),
        decoration: BoxDecoration(
          color: active ? widget.activeColor      // 👈 active color
                        : widget.inactiveColor,   // 👈 inactive color
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }),
)

      ],
    );
  }

  Widget _promoCard(BuildContext context, String image, double r) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(r),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child:  Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
