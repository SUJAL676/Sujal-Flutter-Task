import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/models/reel_model.dart';
import '../provider/reel_provider.dart';

class ReelOverlay extends StatefulWidget {
  final ReelModel reel;

  const ReelOverlay({
    super.key,
    required this.reel,
  });

  @override
  State<ReelOverlay> createState() =>
      _ReelOverlayState();
}

class _ReelOverlayState
    extends State<ReelOverlay> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final caption = widget.reel.caption;

    final shouldTruncate =
        caption.length > 40;

    String displayCaption = caption;

    if (!isExpanded && shouldTruncate) {
      displayCaption =
      "${caption.substring(0, 40)}...";
    }

    return Positioned(
      bottom: 40,
      left: 16,
      right: 16,
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor:
                      Colors.white24,
                      child: Text(
                        widget.reel.username
                            .substring(0, 1)
                            .toUpperCase(),
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontWeight: FontWeight.w900
                        ),

                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Text(
                      "@${widget.reel.username}",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                    )
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: () {
                    if (!shouldTruncate) {
                      return;
                    }

                    setState(() {
                      isExpanded =
                      !isExpanded;
                    });
                  },
                  child: AnimatedSize(
                    duration:
                    const Duration(
                      milliseconds: 250,
                    ),
                    curve:
                    Curves.easeInOut,
                    child: Text(
                      displayCaption,
                        style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 14,
                          height: 1.4
                        )


                    ),
                  ),
                ),
              ],
            ),
          ),



          Consumer<ReelProvider>(
            builder: (_, provider, __) {
              final isLiked =
              provider.likedReels
                  .contains(widget.reel.id);

              final isBookmarked =
              provider.bookmarkedReels
                  .contains(widget.reel.id);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("id");
                      print(widget.reel.id);
                      provider.toggleLike(
                        widget.reel.id,
                      );
                    },
                    child: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isLiked
                          ? Colors.red
                          : Colors.white,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    widget.reel.likes.toString(),
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      provider.toggleBookmark(
                        widget.reel.id,
                      );
                    },
                    child: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isBookmarked
                          ? Colors.amber
                          : Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
