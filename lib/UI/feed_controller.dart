import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcasts/models/podcast.dart';

var feedProvider = StreamProvider((ref) {
  var controller = ThreadFeedController(ref);
  return controller.getFeed();
});

class ThreadFeedController {
  Ref ref;

  ThreadFeedController(this.ref);

  Stream<List<Podcast>> getFeed() async* {
    await Future.delayed(const Duration(milliseconds: 800));
    List<Podcast> lst = [
      Podcast(
          n: "Follow Your Passion is Terrible Advice. Here's Why.",
          text: "10 mins",
          url: "url",
          image: "https://www.linkpicture.com/q/passion_1.png"),
      Podcast(
          n: "A day in the life of a billionaire.",
          text: "12 mins",
          url: "url",
          image:
              "https://firebasestorage.googleapis.com/v0/b/adg-forums-4644c.appspot.com/o/posts%2Flife%20of%20money.png?alt=media&token=f1e6231c-a948-45a2-8bfb-9b181484177b"),
      Podcast(
          n: "Follow Your Passion is Terrible Advice. Here's Why.",
          text: "10 mins",
          url: "url",
          image: "https://www.linkpicture.com/q/passion_1.png"),
      Podcast(
          n: "A day in the life of a billionaire.",
          text: "12 mins",
          url: "url",
          image:
              "https://firebasestorage.googleapis.com/v0/b/adg-forums-4644c.appspot.com/o/posts%2Flife%20of%20money.png?alt=media&token=f1e6231c-a948-45a2-8bfb-9b181484177b")
    ];

    yield lst;
  }
}
