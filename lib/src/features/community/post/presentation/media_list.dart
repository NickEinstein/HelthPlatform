import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';

class MediaGallery extends ConsumerStatefulWidget {
  final int groupId;

  const MediaGallery({Key? key, required this.groupId}) : super(key: key);

  @override
  ConsumerState<MediaGallery> createState() => _MediaGalleryState();
}

class _MediaGalleryState extends ConsumerState<MediaGallery> {
  @override
  Widget build(BuildContext context) {
    final mediaAsync = ref.watch(userAllMediaProvider(widget.groupId));

    return mediaAsync.when(
      data: (mediaList) {
        if (mediaList.isEmpty) {
          return Column(
            children: [
              mediumSpace(),
              const Center(child: Text('No media found.')),
            ],
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: mediaList.length,
          itemBuilder: (context, index) {
            final media = mediaList[index];
            final url = media.mediaUrl!.startsWith('http')
                ? media.mediaUrl
                : '${AppConstants.noSlashImageURL}${media.mediaUrl}';

            return GestureDetector(
              onTap: () => _showFullImage(context, url),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  url!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Column(
        children: [
          mediumSpace(),
          const Center(child: Text('No media found.')),
        ],
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10), // optional
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: InteractiveViewer(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
                maxHeight: 600,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
