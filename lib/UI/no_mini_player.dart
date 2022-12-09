import 'package:flutter/material.dart';
import 'package:podcasts/UI/loading.dart';

class NoMiniPlayer extends StatelessWidget {
  const NoMiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleSkeleton(
          size: 50,
        ),
        const Skeleton(
          height: 20,
          width: 200,
        ),
        Icon(
          Icons.play_arrow,
          size: 40,
          color: Colors.black.withOpacity(0.2),
        )
      ],
    );
  }
}
