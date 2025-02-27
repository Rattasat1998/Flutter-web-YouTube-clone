import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../keys.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final YoutubeAPI _youtubeAPI = YoutubeAPI(Keys.youtubeKey); // key from google api

  bool loading = false;

  List<YouTubeVideo> result = [];
  String _query = 'flutter bloc';

  getVideoFromYouTube() async {
    try {result =
    await _youtubeAPI.search(_query, order: 'relevance', videoDuration: 'any', type: 'video');
    result = await _youtubeAPI.nextPage();} catch (e){
      print(e);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loading = true;
    super.initState();
    getVideoFromYouTube();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tags = [
      'one',
      'two',
      'Grey',
      'Green',
      'Color',
      'Menu',
      'Food',
      'Asp',
      'two',
      'Grey',
      'Green',
      'Color',
      'Menu',
      'Food',
      'Asp',
      'two',
      'Grey',
      'Green',
      'Color',
      'Menu',
      'Food',
      'Asp',
      'two',
      'Grey',
      'Green',
      'Color',
      'Menu',
      'Food',
      'Asp',
      'Grey',
      'Green',
      'Color',
      'Menu',
      'Food',
      'Asp',
      'two',
      'Grey',
      'Green',
      'Color',
      'Menu',
      'Food',
      'Asp',
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: _buildAppBar(context),
      body: Row(
        children: [
          _buildLeftMenu(context),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: loading
                    ? CupertinoActivityIndicator()
                    : Column(
                        children: [
                          _buildTags(tags),
                          // TODO get data from api
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  itemCount: result.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    YouTubeVideo item = result[index];

                                    return GestureDetector(
                                      onTap: (){
                                        print('watch');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: 200,
                                                width: MediaQuery.of(context).size.width,
                                                child: YoutubePlayer(controller: YoutubePlayerController.fromVideoId(
                                                    videoId: extractVideoId(
                                                      item.url.toString(),
                                                    )))),
                                            Text(item.title, style: Theme.of(context).textTheme.headline6),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
              ))
        ],
      ),
    );
  }

  String extractVideoId(String url) {
    RegExp regExp = RegExp(
      r'(?:youtu\.be/|youtube\.com/(?:embed/|v/|watch\?v=|watch\?.+&v=))([^&?/ ]{11})',
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw Exception('Invalid YouTube video URL');
    }
  }

  _buildTags(List<String> tags) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      primary: true,
      child: Row(
        children: tags
            .map((e) => Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(e, style: const TextStyle(color: Colors.white))))
            .toList(),
      ),
    );
  }

  Expanded _buildLeftMenu(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildButtonMenu(context: context, title: 'Home', icon: Icons.home, isSelected: true),
              _buildButtonMenu(
                  context: context, title: 'Shorts', icon: Icons.video_library_outlined),
              _buildButtonMenu(
                  context: context, title: 'Subscriptions', icon: Icons.subscriptions_outlined),
              _buildButtonMenu(
                  context: context, title: 'Originals', icon: Icons.video_library_outlined),
              _buildButtonMenu(
                  context: context, title: 'YouTube Music', icon: Icons.library_music_outlined),
              const Divider(thickness: .5, color: Colors.grey),
              _buildButtonMenu(
                  context: context, title: 'Library', icon: Icons.library_books_rounded),
              _buildButtonMenu(context: context, title: 'History', icon: Icons.history),
              _buildButtonMenu(context: context, title: 'Your video', icon: Icons.ondemand_video),
              _buildButtonMenu(
                  context: context, title: 'Watch later', icon: Icons.watch_later_outlined),
              _buildButtonMenu(context: context, title: 'Downloads', icon: Icons.download),
              _buildButtonMenu(context: context, title: 'Your Clips', icon: Icons.video_collection),
              _buildButtonMenu(
                  context: context, title: 'Show More', icon: Icons.keyboard_arrow_down),
              const Divider(thickness: .5, color: Colors.grey),
              const Text(
                'Subscriptions',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ));
  }

  _buildButtonMenu({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool isSelected = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: !isSelected ? Colors.transparent : Colors.white12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const Icon(Icons.menu),
      elevation: 0,
      title: Row(
        children: [
          Row(
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/640px-YouTube_full-color_icon_%282017%29.svg.png',
                width: 40,
              ),
              const SizedBox(width: 10),
              const Text('YouTube'),
            ],
          ),
          const Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      style: const TextStyle(color: Colors.white),
                      placeholderStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: Icon(Icons.mic),
                    ),
                  ),
                ],
              )),
          const Spacer(),
        ],
      ),
      actions: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Icon(Icons.video_call_outlined),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Icon(Icons.notifications),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Icon(Icons.person),
        ),
      ],
    );
  }
}
