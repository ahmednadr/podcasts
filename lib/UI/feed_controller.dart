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
    List<Podcast> lst = [
      Podcast(
          n: "How will AI change the world we know today?",
          text: "10 mins",
          url:
              "http://${ips.last}:5000/audio/how%20will%20ai%20change%20the%20world.webm",
          image:
              "https://firebasestorage.googleapis.com/v0/b/adg-forums-4644c.appspot.com/o/posts%2FScreenshot%202022-12-10%20at%2011.37.33%20PM.png?alt=media&token=0506014e-b309-4c23-8e85-c5c3dbe89d36"),
      Podcast(
          n: "Follow Your Passion is Terrible Advice. Here's Why.",
          text: "10 mins",
          url:
              "https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_multichannel_subs.m3u8",
          image: "https://www.linkpicture.com/q/passion_1.png"),
      Podcast(
          n: "Do you really need 8 hours of sleep every single day?",
          text: "12 mins",
          url:
              "https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_multichannel_subs.m3u8",
          image:
              "https://firebasestorage.googleapis.com/v0/b/adg-forums-4644c.appspot.com/o/posts%2FScreenshot%202022-12-10%20at%2011.38.29%20PM.png?alt=media&token=e320bb1c-91d5-43b2-afbb-8d9e8bcf8f1e"),
      Podcast(
          n: "A day in the life of a billionaire.",
          text: "12 mins",
          url:
              "https://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_multichannel_subs.m3u8",
          image:
              "https://firebasestorage.googleapis.com/v0/b/adg-forums-4644c.appspot.com/o/posts%2Flife%20of%20money.png?alt=media&token=f1e6231c-a948-45a2-8bfb-9b181484177b")
    ];

    yield lst;
  }
}
