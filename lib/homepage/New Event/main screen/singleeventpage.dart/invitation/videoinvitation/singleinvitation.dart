import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/videoinvitation/videoinvitepreview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class singlevideoinvite extends StatefulWidget {
  final Map<String, String> orlistsinglevideo;
  const singlevideoinvite({super.key, required this.orlistsinglevideo});

  @override
  State<singlevideoinvite> createState() => _singlevideoinviteState();
}

class _singlevideoinviteState extends State<singlevideoinvite> {
  late final List<MapEntry<String, String>> subvideoall =
      widget.orlistsinglevideo.entries.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 232, 232),
      body: SafeArea(
          child: Container(
              child: Column(
        children: [
          titlebar(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(child: listsofvideo()),
        ],
      ))),
    );
  }

  Widget titlebar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 235, 232, 232),
      ),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            const SizedBox(width: 4),
            IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87),
              onPressed: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: Text(
                "Invitation List",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),
            // Spacer for symmetry
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget listsofvideo() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemCount: subvideoall.length,
      itemBuilder: (context, index) {
        final item = subvideoall[index]; // MapEntry<String, String>
        return _PremiumVideoCard(
          imageAsset: item.key,
          title: item.value,
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => videopreview(
                          videoimage: item.key,
                        )));
            // final title = item.value.trim().toLowerCase();
            // final isWedding = title.contains('wedding');
            // if (isWedding) {
            //   await videosubcategory(); // open sheet
            //   return;
            // }
            // if (!mounted) return;
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (_) => const singlevideoinvite()),
            // );
          },
          heroTag: 'video_$index',
        );
      },
    );
  }
}

class _PremiumVideoCard extends StatefulWidget {
  final String imageAsset;
  final String title;
  final VoidCallback? onTap;
  final String heroTag;

  const _PremiumVideoCard({
    required this.imageAsset,
    required this.title,
    required this.heroTag,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_PremiumVideoCard> createState() => _PremiumVideoCardState();
}

class _PremiumVideoCardState extends State<_PremiumVideoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  )..forward();

  late final Animation<double> _scale =
      CurvedAnimation(parent: _c, curve: Curves.easeOutBack);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            //
            //
            //
          },
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(18),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Column(
                  children: [
                    // Thumbnail with overlay
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.170,
                          width: double.infinity,
                          child: Image.asset(
                            widget.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Color(0x66000000)],
                              ),
                            ),
                          ),
                        ),
                        // play chip
                        Positioned(
                          right: MediaQuery.of(context).size.height * 0.06,
                          bottom: MediaQuery.of(context).size.width * 0.150,
                          child: _glassChip(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.play_arrow_rounded, size: 18),
                                SizedBox(width: 4),
                                Text("Play"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Title + meta
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1C1C1E),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                // tiny accent bar
                                Container(
                                  width: 18,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.darkGold,
                                        AppColors.lightGold
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "HD • 4–8 min",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassChip({required Widget child}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true, // tap outside to close
          builder: (ctx) => const VideoPopup(
              url: "https://www.youtube.com/watch?v=BBAyRBTfsOU"),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.75),
          border: Border.all(color: Colors.white.withOpacity(0.9), width: 0.6),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 3),
              color: Color(0x14000000),
            ),
          ],
        ),
        child: DefaultTextStyle.merge(
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
          ),
          child: child,
        ),
      ),
    );
  }
}

class VideoPopup extends StatefulWidget {
  final String url;
  const VideoPopup({super.key, required this.url});

  @override
  State<VideoPopup> createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.url)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      child: AspectRatio(
        aspectRatio: 20 / 15,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}
