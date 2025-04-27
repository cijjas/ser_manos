import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ser_manos/shared/cells/cards/card_novedades.dart';

import '../../cells/header/header.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class NewsPiece {
  final String type;
  final String name;
  final String description;
  final String imageUrl;

  NewsPiece({
    required this.type,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class NewsPage extends StatelessWidget {
  final List<NewsPiece> news = [
    NewsPiece(
      type: "Tipo 1",
      name: "Título 1",
      description: "Descripción 1",
      imageUrl: "https://picsum.photos/300/200",
    ),
    NewsPiece(
      type: "Tipo 2",
      name: "Título 2",
      description: "Descripción 2",
      imageUrl: "https://picsum.photos/300/200",
    ),
    NewsPiece(
      type: "Tipo 2",
      name: "Título 2",
      description: "Descripción 2",
      imageUrl: "https://picsum.photos/300/200",
    ),
    NewsPiece(
      type: "Tipo 2",
      name: "Título 2",
      description: "Descripción 2",
      imageUrl: "https://picsum.photos/300/200",
    ),
  ];

  NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsPiece = news[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CardNovedades(
                  type: newsPiece.type,
                  name: newsPiece.name,
                  description: newsPiece.description,
                  imgUrl: newsPiece.imageUrl,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}