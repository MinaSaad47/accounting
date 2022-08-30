import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({Key? key, String? title, TabBar? tabBar})
      : super(
          key: key,
          leadingWidth: 100,
          title: title != null ? Text(title) : null,
          bottom: tabBar,
          leading: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    );
                  },
                ),
                const SizedBox(width: 5),
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Navigator.of(context).popUntil(
                          (route) => route.settings.name == '/',
                        );
                      },
                      icon: const Icon(Icons.arrow_back_sharp),
                    );
                  },
                )
              ],
            ),
          ),
        );
}
