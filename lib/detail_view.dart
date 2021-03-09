import 'package:flutter/material.dart';
import 'package:flutter_app_store_ui_with_hero/app_store_list_view.dart';

class DetailView extends StatelessWidget {
  const DetailView({required this.arguments});
  final DetailViewArguments arguments;

  final body1 = '''
Today, we’re pleased to announce the release of Flutter 2. 
It’s been a little more than two years since the Flutter 1.0 release, but in that short time, we’ve closed 24,541 issues and merged 17,039 PRs from 765 contributors.
Just since the Flutter 1.22 release in September, we’ve closed 5807 issues and merged 4091 PRs from 298 contributors.
Special thanks go out to our volunteer contributors who generously give their spare time to improve the Flutter project.
The top volunteer contributors for the Flutter 2 release were xu-baolin with 46 PRs, a14n with 32 PRs that focused on bringing Flutter to null safety, and hamdikahloun with 20 PRs that improved a number of the Flutter plugins.
But it’s not just coders that contribute to the Flutter project; a great set of volunteer PR reviewers were also responsible for reviewing 1525 PRs, including hamdikahloun (again!), CareF and YazeedAlKhalaf (who’s only 16!). Flutter is truly a community effort and we couldn’t have gotten to version 2 without the issue raisers, PR contributors, and code reviewers. This release is for all of you.
  ''';

  final body2 = '''
Adapting to screen size & input devices
User interface controls adapt their density, hit areas,
and presentation based on screen size and whether the user is using touch or mouse/keyboard.
Keyboard shortcuts, scroll wheel, and right-click accelerate tasks when available.''';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'card-${arguments.heroId}',
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              // pinned: true, AppBarを固定表示する
              elevation: 0,
              stretch: true,
              flexibleSpace: _flexibleSpaceBar(),
              expandedHeight: 360,
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: Colors.pink,
                  onPressed: () {},
                ),
              ],
            ),
            SliverList(
              delegate: _sliverChildListDelegate(),
            )
          ],
        ),
      ),
    );
  }

  Widget _flexibleSpaceBar() {
    return FlexibleSpaceBar(
      stretchModes: const <StretchMode>[
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      title: const Text(
        'Flutter 2 is here',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      background: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            fit: BoxFit.cover,
            image: AssetImage(arguments.imagePath),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, 0.5),
                end: Alignment(0, 0),
                colors: <Color>[
                  Color(0x60000000),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverChildListDelegate _sliverChildListDelegate() {
    return SliverChildListDelegate(
      <Widget>[
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Today, we’re pleased to announce the release of Flutter 2',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                body1,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
              const Text(
                'Adapting to screen size & input devices',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                body2,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        )
      ],
    );
  }
}
