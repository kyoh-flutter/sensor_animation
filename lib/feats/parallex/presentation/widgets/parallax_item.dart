import 'package:flutter/material.dart';

class ParallaxItem extends StatelessWidget {
  final GlobalKey imageKey = GlobalKey();
  final int index;
  final ImageProvider img;

  ParallaxItem({
    required this.img,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      width: 400,
      height: 150,
      child: ClipRRect(
        child: _buildParallaxBackground(context),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
        delegate: ParallaxFlowDelegateVertical(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          imageKey: imageKey,
        ),
        children: [
          Image(image: img, key: imageKey, fit: BoxFit.cover),
        ]);
  }
}

class ParallaxFlowDelegateVertical extends FlowDelegate {
  ParallaxFlowDelegateVertical({
    required this.scrollable,
    required this.listItemContext,
    required this.imageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey imageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // 위치 값 알아내기
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(listItemBox.size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // 스크롤 위치에 따라 배경 이미지 위치 조정
    final viewportDimension = scrollable.position.viewportDimension;
    // scrollFraction : 스크롤 위치를 0.0 ~ 1.0 사이로 정규화
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);
    // verticalAlignment : 세로 정렬
    final verticalAlignment = Alignment(0.0, scrollFraction * 2.2 - 1);

    // 배경 이미지 크기 알아내기
    final bgSize = (imageKey.currentContext!.findRenderObject() as RenderBox).size;
    final listItemSize = context.size;
    // inscribe : Returns a rect of the given size, aligned within given rect as specified by this alignment.
    // inscribe : 주어진 크기의 사각형을 반환하고, 이 정렬에 의해 지정된 사각형 내에서 정렬합니다.
    final childRect = verticalAlignment.inscribe(bgSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegateVertical oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        imageKey != oldDelegate.imageKey;
  }
}
