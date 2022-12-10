import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/models/podcast.dart';

final selectedPodcastProvider = StateProvider<Podcast?>((ref) => null);

final audioPlayerControllerProvider = StateProvider<AudioPlayer>((ref) {
  var podcast = ref.watch(selectedPodcastProvider.state).state;
  AudioPlayer player = AudioPlayer();
  if (podcast != null) {
    player.setUrl(podcast.url);
    player.play();
  }
  return player;
});
