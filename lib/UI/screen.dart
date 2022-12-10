import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcasts/UI/player.dart';
import 'audio_player_controller.dart';
import 'podcasts_feed.dart';

class Screen extends StatefulWidget {
  const Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: ((context, ref, _) {
        var selectedPodcast = ref.watch(selectedPodcastProvider);
        return Stack(children: [
          const PodcastsFeed(),
          DetailedPlayer(
            audioObject: selectedPodcast,
          ),
        ]);
      }),
    ));
  }
}
