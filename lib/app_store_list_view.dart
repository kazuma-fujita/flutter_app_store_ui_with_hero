import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'detail_view.dart';

class Const {
  static const routeDetail = '/detail';
}

class AppStoreListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        if (arguments is DetailViewArguments) {
          switch (settings.name) {
            case Const.routeDetail:
              return PageRouteBuilder<DetailView>(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DetailView(arguments: arguments),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  });
            default:
              return MaterialPageRoute<DetailView>(
                builder: (context) => DetailView(arguments: arguments),
              );
          }
        }
        return null;
      },
      home: AppStoreList(),
    );
  }
}

class AppStoreList extends StatelessWidget {
  final items = [
    'assets/images/image1.webp',
    'assets/images/image2.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('App Store'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) =>
          ListCardItem(items[index], index),
    );
  }
}

@immutable
class DetailViewArguments {
  const DetailViewArguments({required this.imagePath, required this.heroId});
  final String imagePath;
  final int heroId;
}

class ListCardItem extends HookWidget {
  const ListCardItem(this.imagePath, this.heroId);
  final String imagePath;
  final int heroId;

  @override
  Widget build(BuildContext context) {
    final isPushed = useState<bool>(false);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 24),
        padding: EdgeInsets.all(isPushed.value ? 24 : 0),
        child: GestureDetector(
          onTapDown: (TapDownDetails downDetails) {
            isPushed.value = true;
          },
          onTap: () {
            isPushed.value = false;
            Navigator.pushNamed(context, Const.routeDetail,
                arguments:
                    DetailViewArguments(imagePath: imagePath, heroId: heroId));
          },
          onTapCancel: () {
            isPushed.value = false;
          },
          child: Hero(
            tag: 'card-$heroId',
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 16,
              child: SizedBox(
                height: 360,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
