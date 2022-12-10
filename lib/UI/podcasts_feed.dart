import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:podcasts/UI/card.dart';
import 'package:podcasts/UI/feed_controller.dart';
import 'package:podcasts/UI/loading.dart';

class PodcastsFeed extends ConsumerStatefulWidget {
  const PodcastsFeed({super.key});

  @override
  ConsumerState<PodcastsFeed> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<PodcastsFeed> {
  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(feedProvider);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverAppBar(
                shape: const Border(
                    bottom: BorderSide(color: Colors.black12, width: 2)),
                elevation: 0,
                toolbarHeight: 80,
                foregroundColor: Colors.black87,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                centerTitle: false,
                title: const Text(
                  "Podcasts",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      letterSpacing: -1.5),
                )),
          )
        ],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: controller.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => SmallCard(data[index]),
                );
              },
              error: (err, stack) => Text('Error: $err'),
              loading: () => const Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: UiLoading(),
                  ))),
        ),
      ),
    );
  }
}
