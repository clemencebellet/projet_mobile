import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_1/inscription.dart';
import 'package:firebase_core/firebase_core.dart';



class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  static const double kImageHeight = 200;
  static const double kBorderRadius = 16;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double progress;
    if (_controller.hasClients) {
      progress = (_controller.offset / kImageHeight).clamp(0, 1);
    } else {
      progress = 0;
    }

    return Scaffold(
      body: Stack(
        children: [
          _ProductImage(
            url:
            'https://unsplash.com/photos/UC0HZdUitWY/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8M3x8Zm9vZHxmcnwwfHx8fDE2NzYyODA2MjY&force=true&w=1920',
            opacity: progress,
          ),
          _ProductCard(
            radius: kBorderRadius - (kBorderRadius * progress),
            scrollController: _controller,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(onScroll);
    super.dispose();
  }
}

class _ProductImage extends StatelessWidget {
  final String url;
  final double opacity;

  _ProductImage({required this.url, required this.opacity, Key? key})
      : assert(url.startsWith('http')),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _DetailState.kImageHeight,
      foregroundDecoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity),
      ),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) => _isLoaded(progress)
            ? child
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  bool _isLoaded(ImageChunkEvent? image) {
    return image == null ||
        image.cumulativeBytesLoaded == image.expectedTotalBytes;
  }
}

class _ProductCard extends StatelessWidget {
  final ScrollController scrollController;
  final double radius;

  const _ProductCard(
      {required this.scrollController, required this.radius, Key? key})
      : assert(radius >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius cornerRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
            top: _DetailState.kImageHeight * 0.75),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: cornerRadius,
        ),
        child: ClipRRect(
          borderRadius: cornerRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ligne 1"),
                const Text("Ligne 2"),
                const SizedBox(
                  height: 1000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
