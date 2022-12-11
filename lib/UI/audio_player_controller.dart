import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/models/podcast.dart';

final selectedPodcastProvider = StateProvider<Podcast?>((ref) => null);
final audioplayer = StateProvider<AudioPlayer>((ref) => AudioPlayer());
final audioPlayerControllerProvider =
    StateProvider.autoDispose<AudioPlayer>((ref) {
  AudioPlayer player = ref.read(audioplayer);
  var podcast = ref.watch(selectedPodcastProvider.state).state;
  if (podcast != null) {
    player.setUrl(podcast.url);

    player.play();
  }
  return player;
});
