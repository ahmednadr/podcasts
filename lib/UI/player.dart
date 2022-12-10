import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:podcasts/UI/audio_player_controller.dart';
import 'package:podcasts/UI/no_mini_player.dart';
import 'package:podcasts/models/podcast.dart';
import 'loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const double playerMinHeight = 100;
double playerMaxHeight = 400;
const miniplayerPercentageDeclaration = 0.4;

final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(playerMinHeight);

final MiniplayerController widgetController = MiniplayerController();

class DetailedPlayer extends ConsumerStatefulWidget {
  final Podcast? audioObject;

  const DetailedPlayer({Key? key, required this.audioObject});
  double valueFromPercentageInRange(
      {required final double min, max, percentage}) {
    return percentage * (max - min) + min;
  }

  double percentageFromValueInRange({required final double min, max, value}) {
    return (value - min) / (max - min);
  }

  @override
  ConsumerState<DetailedPlayer> createState() => _DetailedPlayerState();
}

class _DetailedPlayerState extends ConsumerState<DetailedPlayer> {
  @override
  Widget build(BuildContext context) {
    (widget.audioObject == null)
        ? playerMaxHeight = playerMinHeight
        : playerMaxHeight = 400;

    final AudioPlayer audioplayer = ref.watch(AudioPlayerControllerProvider);
    void onTapPlayPause() {
      audioplayer.playing ? audioplayer.pause() : audioplayer.play();
    }

    void onTapForward() {
      audioplayer.seek(audioplayer.duration! + const Duration(seconds: 30));
    }

    void onTapBack() {
      audioplayer.seek(audioplayer.duration! - const Duration(seconds: 10));
    }

    return Miniplayer(
        valueNotifier: playerExpandProgress,
        minHeight: playerMinHeight,
        maxHeight: playerMaxHeight,
        controller: widgetController,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        curve: Curves.easeOut,
        builder: (height, percentage) {
          if (widget.audioObject != null) {
            final bool miniplayer =
                percentage < miniplayerPercentageDeclaration;
            final double width = MediaQuery.of(context).size.width;
            final maxImgSize = width * 0.4;

            final text = Text(
              widget.audioObject!.n,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            );
            var buttonPlay = IconButton(
              icon: Icon(Icons.pause),
              onPressed: onTapPlayPause,
            );
            var progressIndicator = LinearProgressIndicator(
              value: 0.3,
              // value: audioplayer.duration!.inSeconds / 10, // TODO: audio time
              // ref.read(selectedPodcastProvider).text,
              color: Colors.orange,
              backgroundColor: Colors.grey,
            );

            //Declare additional widgets (eg. SkipButton) and variables
            if (!miniplayer) {
              var percentageExpandedPlayer = widget.percentageFromValueInRange(
                  min: playerMaxHeight * miniplayerPercentageDeclaration +
                      playerMinHeight,
                  max: playerMaxHeight,
                  value: height);
              if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
              final paddingVertical = widget.valueFromPercentageInRange(
                  min: 0, max: 20, percentage: percentageExpandedPlayer);
              final double heightWithoutPadding =
                  height - paddingVertical * 2 - 10;

              final double imageSize = heightWithoutPadding > maxImgSize
                  ? maxImgSize
                  : heightWithoutPadding;

              final paddingLeft = widget.valueFromPercentageInRange(
                    min: 48,
                    max: width - imageSize,
                    percentage: percentageExpandedPlayer,
                  ) /
                  2;

              var buttonSkipForward = IconButton(
                icon: Icon(Icons.forward_30),
                iconSize: 40,
                onPressed: onTapForward,
              );
              var buttonSkipBackwards = IconButton(
                icon: Icon(Icons.replay_10),
                iconSize: 40,
                onPressed: onTapBack,
              );
              var buttonPlayExpanded = IconButton(
                icon: Icon(Icons.pause_outlined),
                iconSize: 60,
                onPressed: onTapPlayPause,
              );
              final imgExpanded = ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.audioObject!.image,
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.cover,
                ),
              );

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: percentage * 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: percentageExpandedPlayer,
                        child: const Skeleton(
                          height: 5,
                          width: 100,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: paddingLeft - 24 < 0 ? 20 : paddingLeft - 5,
                              top: paddingVertical,
                              bottom: paddingVertical),
                          child: SizedBox(
                            height: imageSize,
                            child: imgExpanded,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 33),
                          child: Opacity(
                            opacity: percentageExpandedPlayer,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(child: text),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buttonSkipBackwards,
                                      buttonPlayExpanded,
                                      buttonSkipForward
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            //Miniplayer
            final percentageMiniplayer = widget.percentageFromValueInRange(
                min: playerMinHeight,
                max: playerMaxHeight * miniplayerPercentageDeclaration +
                    playerMinHeight,
                value: height);

            final imgSmall = ClipRRect(
              borderRadius: BorderRadius.circular(20 - percentage * 10),
              child: Image.network(
                widget.audioObject!.image,
                height: 50 + percentage * 250,
                width: 50 + percentage * 250,
                fit: BoxFit.cover,
              ),
            );

            final elementOpacity = 1 - 1 * percentageMiniplayer;

            return Column(
              children: [
                progressIndicator,
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: maxImgSize),
                        child: imgSmall,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Opacity(
                            opacity: elementOpacity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.audioObject!.n,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 16)),
                                Text(
                                  widget.audioObject!.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color!
                                            .withOpacity(0.55),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Opacity(
                          opacity: elementOpacity,
                          child: buttonPlay,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const NoMiniPlayer();
          }
        });
  }
}
