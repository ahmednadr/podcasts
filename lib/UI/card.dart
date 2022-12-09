import 'package:flutter/material.dart';
import 'package:podcasts/UI/screen.dart';
import '../models/podcast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class SmallCard extends ConsumerStatefulWidget {
  late String n;
  late String image;
  late String text;
  late String url;
  late Podcast p;

  SmallCard(this.p, {Key? key}) : super(key: key) {
    n = p.n;
    text = p.text;
    image = p.image;
    url = p.url;
  }

  @override
  ConsumerState<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends ConsumerState<SmallCard> {
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image,
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text(
                        widget.n,
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      // ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text(
                        widget.text,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      // ),
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
