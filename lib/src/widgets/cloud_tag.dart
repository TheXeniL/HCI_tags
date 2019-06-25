import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:map_tags/src/models/place_tags.dart';

class CloudTag extends StatelessWidget {
  final List<PlaceTag> tags;

  CloudTag(this.tags);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < tags.length; i++) {
      widgets.add(ScatterItem(tags[i], i));
    }

    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return Center(
      child: FittedBox(
        child: Scatter(
          fillGaps: true,
          delegate: ArchimedeanSpiralScatterDelegate(ratio: ratio),
          children: widgets,
        ),
      ),
    );
  }
}

class ScatterItem extends StatelessWidget {
  ScatterItem(this.tag, this.index);
  final PlaceTag tag;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.body1.copyWith(
          fontSize: tag.size.toDouble(),
        );
    return RotatedBox(
      quarterTurns: 0,
      child: Text(
        tag.tag,
        style: style,
      ),
    );
  }
}
