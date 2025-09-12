import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/Einvitation/e-invitation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class singleeinvite extends StatefulWidget {
  final String imagevalue;
  const singleeinvite({super.key, required this.imagevalue});

  @override
  State<singleeinvite> createState() => _singleeinviteState();
}

class _singleeinviteState extends State<singleeinvite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(widget.imagevalue))),
                      ),
                      Positioned(
                          top: 50.0,
                          left: 20.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Einvitation()));
                            },
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade300),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 20.0,
                                  color: Colors.black,
                                )),
                          )),
                    ],
                  ),
                  Container(
                    color: AppColors.buttoncolor,
                    height: 3.0,
                    width: double.infinity,
                  ),
                  InvitationHalfScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvitationHalfScreen extends StatelessWidget {
  const InvitationHalfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Gathbandhan Invitation Template",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              "Celebrate the sacred bond of marriage with our Gathbandhan Invitation Template image. "
              "This auspicious invitation holds the essence of a traditional Indian wedding ceremony, "
              "featuring intricate designs, vibrant colors, and heartfelt messages.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),

            // Pricing
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "FREE",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                    // fontSize: 14,
                    // fontWeight: FontWeight.w600,
                    // color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Pay ₹ 399.00 ",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  "(for HD Quality and Remove Watermark)",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => WebViewPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttoncolor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text("Create Now",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFF9A825)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text("Add to wishlist",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // What You Do
            Text(
              "What You Do",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            _buildPoint(
                "Customize the video with your own text like Names, Date, Address, etc."),
            _buildPoint("No Watermark or Branding on the paid video."),
            _buildPoint(
                "Video will be created within 2–5 minutes and available to download immediately."),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.star, color: Color(0xFFF9A825), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => _progress = p / 100),
        ),
      )
      ..loadRequest(Uri.parse("https://create.futureminds.io/img/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Template Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (await _controller.canGoBack()) {
              _controller.goBack(); // WebView back
            } else {
              Navigator.pop(context); // App back
            }
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: _progress < 1
              ? LinearProgressIndicator(value: _progress)
              : const SizedBox(height: 3),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
