import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WhatsappOverlay extends StatefulWidget {
  final Offset startOffset;
  final Size startSize;
  final String imageUrl;
  final VoidCallback onClose;

  const WhatsappOverlay({
    required this.startOffset,
    required this.startSize,
    required this.imageUrl,
    required this.onClose,
  });

  @override
  State<WhatsappOverlay> createState() => _WhatsappOverlayState();
}

class _WhatsappOverlayState extends State<WhatsappOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    const double endSize = 300;

    final endOffset = Offset(
      (screen.width - endSize) / 2,
      (screen.height - endSize) / 2,
    );

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          controller.reverse().then((_) => widget.onClose());
        },
        child: Stack(
          children: [
            // Background fade (same screen visible)
            AnimatedBuilder(
              animation: animation,
              builder: (_, __) => Container(
                color: Colors.black.withOpacity(0.6 * animation.value),
              ),
            ),

            // Image zoom animation
            AnimatedBuilder(
              animation: animation,
              builder: (_, __) {
                final left = lerpDouble(
                  widget.startOffset.dx,
                  endOffset.dx,
                  animation.value,
                )!;
                final top = lerpDouble(
                  widget.startOffset.dy,
                  endOffset.dy,
                  animation.value,
                )!;
                final size = lerpDouble(
                  widget.startSize.width,
                  endSize,
                  animation.value,
                )!;

                return Positioned(
                  left: left,
                  top: top,
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        lerpDouble(100, 16, animation.value)!,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showWhatsappProfilePreview(
  BuildContext context,
  profileUrl,
  GlobalKey profileKey,
) {
  final renderBox = profileKey.currentContext!.findRenderObject() as RenderBox;

  final startOffset = renderBox.localToGlobal(Offset.zero);
  final startSize = renderBox.size;

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => WhatsappOverlay(
      startOffset: startOffset,
      startSize: startSize,
      imageUrl: profileUrl,
      onClose: () => entry.remove(),
    ),
  );

  Overlay.of(context).insert(entry);
}
