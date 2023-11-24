import 'package:education_app/core/res/assets.dart';

class PageContent {
  PageContent({
    required this.assetPath,
    required this.title,
    required this.description,
  });

  PageContent.first()
      : this(
          assetPath: Assets.vectors.casualReadingPNG,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed'
              " by the world's top professors",
        );
  PageContent.second()
      : this(
          assetPath: Assets.vectors.casualLifePNG,
          title: 'Brand a fun atmosphere',
          description: 'This is the first online education platform designed'
              " by the world's top professors",
        );
  PageContent.third()
      : this(
          assetPath: Assets.vectors.casualMeditationSciencePNG,
          title: 'Easy to join the lesson',
          description: 'This is the first online education platform designed'
              " by the world's top professors",
        );

  final String assetPath;
  final String title;
  final String description;
}
