import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcasts/UI/scan.dart';
import 'package:podcasts/models/podcast.dart';

var feedProvider = StreamProvider((ref) {
  var controller = ThreadFeedController(ref);
  return controller.getFeed();
});

class ThreadFeedController {
  Ref ref;

  ThreadFeedController(this.ref);

  Stream<List<Podcast>> getFeed() async* {
    final scanner = ref.read(scanProvider);
    await scanner.scanNetwork(5000);
    var ips = scanner.ips;
    if (ips.isEmpty) throw Error();
    var response = await Dio().get('http://${ips.last}:5000/podcasts');
    assert(response.statusCode == 200);
    var link =
        "https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_multichannel_subs.m3u8";
    List<Podcast> lst = [];

    for (Map pod in (response.data)) {
      lst.add(Podcast(
        n: pod["name"]!,
        text: pod["duration"]!,
        url: link,
        image: "http://${ips.last}:5000" + (pod["image"]!),
      ));
    }

    yield lst;
  }
}
