import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:just_audio_background/just_audio_background.dart';

final selectedPodcastProvider = StateProvider<Podcast?>((ref) => null);
final audioplayer = StateProvider<AudioPlayer>((ref) => AudioPlayer());
final audioPlayerControllerProvider =
    StateProvider.autoDispose<AudioPlayer>((ref) {
  AudioPlayer player = ref.read(audioplayer);
  var podcast = ref.watch(selectedPodcastProvider.state).state;
  if (podcast != null) {
    var x = AudioSource.uri(Uri.parse(podcast.url),
        tag: MediaItem(
          id: podcast.n,
          album: "Podcasts",
          title: podcast.n,
          artUri: Uri.parse(podcast.image),
        ));
    player.setAudioSource(x);
    player.play();
  }
  return player;
});
