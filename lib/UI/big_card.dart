import 'package:flutter/material.dart';
import 'package:podcasts/UI/audio_player_controller.dart';
import '../models/podcast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class BigCard extends ConsumerStatefulWidget {
  late String n;
  late String image;
  late String text;
  late String url;
  late Podcast p;

  BigCard(this.p, {Key? key}) : super(key: key) {
    n = p.n;
    text = p.text;
    image = p.image;
    url = p.url;
  }

  @override
  ConsumerState<BigCard> createState() => _SmallCardState();
}

class _SmallCardState extends ConsumerState<BigCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ref.read(selectedPodcastProvider.state).state = widget.p,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Card(
          elevation: 0,
          color: const Color(0X00000000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.n,
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          letterSpacing: -0.5,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.text,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
