import 'package:flutter/material.dart';
import 'package:sensor_animation/feats/parallex/presentation/widgets/parallax_item.dart';

/// A scrollview generating the listItems with parallax background
class ParallaxCards extends StatelessWidget {
  /// overlays list - can add separate overlay to each card

  /// background images list - can have url or asset path - required
  final List<ImageProvider> imagesList;

  const ParallaxCards({
    required this.imagesList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      thickness: 1,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        child: Flex(direction: Axis.vertical, children: generateChildren()),
      ),
    );
  }

  /// generate [ListItem] for each element of the imagesList
  List<Widget> generateChildren() {
    List<Widget> children = [];
    for (int i = 0; i < imagesList.length; i++) {
      children.add(
        ParallaxItem(
          img: imagesList[i],
          index: i,
        ),
      );
    }

    return children;
  }
}
