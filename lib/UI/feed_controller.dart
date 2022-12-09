import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcasts/UI/card.dart';
import 'package:podcasts/models/podcast.dart';

var feedProvider = StreamProvider((ref) {
  var controller = ThreadFeedController(ref);
  return controller.getFeed();
});

class ThreadFeedController {
  Ref ref;

  ThreadFeedController(this.ref);

  Stream<List<Podcast>> getFeed() async* {
    List<Podcast> lst = [
      Podcast(
          n: "Follow Your Passion is Terrible Advice. Here's Why.",
          text: "10 mins",
          url: "url",
          image: "https://www.linkpicture.com/q/passion_1.png")
    ];

    yield lst;
  }
}
