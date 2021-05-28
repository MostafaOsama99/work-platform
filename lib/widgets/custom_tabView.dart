import 'package:flutter/material.dart';

import '../constants.dart';

///used for statistics and team screen
///this widget shows a tab bar with it's listView with custom [ShaderMask] on scroll
class CustomTabView extends StatelessWidget {
  final List<Widget> tabs;
  final BoxDecoration decoration;
  final Widget Function(int i) listView;

  const CustomTabView({Key key, this.tabs, this.listView, this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [COLOR_SCAFFOLD, Colors.transparent, Colors.transparent, Colors.blue],
                      stops: [0.0, 0.03, 0.97, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstOut,
                  child: SizedBox(
                    height: 38,
                    child: TabBar(
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      indicator: decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(50), color: COLOR_ACCENT),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: tabs,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for (int i = 0; i < tabs.length; i++)
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [COLOR_SCAFFOLD, Colors.transparent, Colors.transparent, Colors.blue],
                          stops: [0.0, 0.04, 0.96, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstOut,
                      child: listView(i),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
