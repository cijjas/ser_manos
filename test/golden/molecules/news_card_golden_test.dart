import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:ser_manos/models/news.dart';
import 'package:ser_manos/shared/cells/cards/news_card.dart';
import '../../utils/test_utils.dart';

Widget _frame(Widget w, {ThemeData? theme}) => testApp(
      child: w,
      theme: theme,
    );

News fakeNews(String id) => News(
      id: id,
      title: 'New spaces for volunteering',
      summary:
          'Discover the latest opportunities we’ve opened for community work.',
      sender: 'SerManos',
      imageUrl: 'https://dummyimage.com/300x400/ccc/aaa&text=news',
      description: 'Long **markdown** body …',
      createdAt: DateTime(2025, 6, 1),
    );

void main() {
  testGoldens('NewsCard widget', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'light',
          widget: _frame(NewsCard(news: fakeNews('n1'))),
        )
        ..addScenario(
          name: 'dark',
          widget: _frame(
            NewsCard(news: fakeNews('n1')),
            theme: ThemeData.dark(useMaterial3: true),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 200)); // fonts-settle

      await screenMatchesGolden(tester, 'news_card');
    });
  });
}
