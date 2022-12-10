import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/models/podcast.dart';

final selectedPodcastProvider = StateProvider<Podcast?>((ref) => null);

final AudioPlayerControllerProvider = StateProvider<AudioPlayer>((ref) {
  var podcast = ref.watch(selectedPodcastProvider.state).state;
  AudioPlayer player = AudioPlayer();
  if (podcast != null) player.setUrl(podcast.url);
  return player;
});
