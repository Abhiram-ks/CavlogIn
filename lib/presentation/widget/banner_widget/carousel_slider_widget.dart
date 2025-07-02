import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/media_quary/constant/constant.dart';

class BannerBuilderWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final String title;
  final int number;
  final List<String> imageWidgets;
  final Function(String url, int index, int imageIndex) onDoubleTap;

  const BannerBuilderWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.title,
    required this.number,
    required this.imageWidgets,
    required this.onDoubleTap,
  });

  @override
  State<BannerBuilderWidget> createState() => _BannerBuilderWidgetState();
}

class _BannerBuilderWidgetState extends State<BannerBuilderWidget> {
  final ScrollController _scrollController = ScrollController();

  void scrollToPrevious() {
    _scrollController.animateTo(
      _scrollController.offset - widget.screenWidth * 0.87,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollToNext() {
    _scrollController.animateTo(
      _scrollController.offset + widget.screenWidth * 0.87,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstantWidgets.hight20(context),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: widget.screenHeight * 0.25,
          width: widget.screenWidth,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imageWidgets.length,
                  itemBuilder: (context, imageIndex) {
                    final imageUrl = widget.imageWidgets[imageIndex];
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onLongPress: () {
                        widget.onDoubleTap(imageUrl, widget.number, imageIndex);
                      },
                      child: Container(
                        height: widget.screenHeight * 0.25,
                        width: widget.screenWidth * 0.87,
                        decoration: BoxDecoration(
                          color: AppPalette.trasprentClr,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppPalette.buttonClr,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.photo,
                                    color: AppPalette.greyClr,
                                    size: 50,
                                  ),
                                  Text(
                                    'Oops! Image load failed...',
                                    style: TextStyle(color: AppPalette.blackClr),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Left arrow
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 28),
                  color: Colors.black54,
                  onPressed: scrollToPrevious,
                ),
              ),
              // Right arrow
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 28),
                  color: Colors.black54,
                  onPressed: scrollToNext,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
