import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/constants/style.dart';
import 'package:greenzone_medical/src/model/article_response.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';
import 'package:greenzone_medical/src/utils/extensions/date_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';

class KnowledgeTab extends ConsumerWidget {
  const KnowledgeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: articleState.when(
        data: (articles) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Popular Article Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Article',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(Routes.ALLARTICLESECTION);
                    },
                    child: Text(
                      'See All',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              15.height,
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    articles.length > 6 ? 6 : articles.length,
                    (index) => _buildPopularArticleCard(
                      context,
                      article: articles[index],
                    ),
                  ),
                ),
              ),
              20.height,

              // Articles Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Articles',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(Routes.ALLARTICLESECTION);
                    },
                    child: Text(
                      'See All',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              15.height,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  articles.length < 20 ? articles.length : 16,
                  (index) => _buildArticleItem(
                    context,
                    article: articles[index + 6],
                  ),
                ),
              ),
            ],
          );
        },
        error: (_, __) => const SizedBox.shrink(),
        loading: () => const ListLoader(itemCount: 4),
      ),
    );
  }
}

Widget _buildPopularArticleCard(
  BuildContext context, {
  required ArticleResponse article,
}) {
  return Container(
    width: 160,
    margin: const EdgeInsets.only(right: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300], // Placeholder color
          ),
          child: CachedNetworkImage(
            imageUrl: article.featuredImagePath == null
                ? ''
                : '${AppConstants.noSlashImageURL}${article.featuredImagePath}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) =>
                Text(article.featuredImagePath ?? ''),
          ),
        ),
        10.height,
        Text(
          article.category?.name ?? '',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        5.height,
        Text(
          article.title ?? '',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        5.height,
        Row(
          children: [
            Text(
              DateTime.tryParse(article.publishedDate ?? '')
                      ?.formatDatePretty ??
                  '',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    ),
  );
}

Widget _buildArticleItem(
  BuildContext context, {
  required ArticleResponse article,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                article.featuredImagePath == null
                    ? ''
                    : '${AppConstants.noSlashImageURL}${article.featuredImagePath}',
              ),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {},
            ),
          ),
        ),
        15.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title ?? '',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              5.height,
              Text(
                article.shortDescription ?? '',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    ),
  );
}
