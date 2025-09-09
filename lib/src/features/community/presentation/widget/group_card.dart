import '../../../../utils/network_img_fallback.dart';
import '../../../../utils/packages.dart';

class GroupCard extends ConsumerStatefulWidget {
  // ✅ Convert to ConsumerStatefulWidget
  final String imageUrl;
  final String title;
  final String subtitle;
  final String buttonText;
  final bool isLoading;
  final bool isMember;
  final VoidCallback onButtonPressed;
  final VoidCallback onPressed;
  final VoidCallback? onAcceptedButtonPressed;
  final VoidCallback? onRejecteddButtonPressed;
  final bool isAcceptReject;
  final bool? isSentInvite;
  final bool? isShowMore;
  final String? doctorName;

  const GroupCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.isMember,
    required this.isLoading,
    required this.onPressed,
    this.onAcceptedButtonPressed,
    this.onRejecteddButtonPressed,
    this.isAcceptReject = false,
    this.isSentInvite = false,
    this.isShowMore = false,
    required this.onButtonPressed,
    this.doctorName,
  }) : super(key: key);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends ConsumerState<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                widget.imageUrl.startsWith('http')
                    ? widget.imageUrl
                    : '${AppConstants.noSlashImageURL}${widget.imageUrl}',
                width: 80,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Handle name split and initials
                  final fullName = widget.title;
                  final nameParts = fullName.trim().split(RegExp(r'\s+'));
                  String initials = '';
                  final nonTitleParts =
                      nameParts.where((p) => !p.endsWith('.')).toList();
                  if (nonTitleParts.isNotEmpty) {
                    initials += nonTitleParts.first[0];
                    if (nonTitleParts.length > 1) {
                      initials += nonTitleParts.last[0];
                    }
                  }

                  return Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      color: getAvatarColor(fullName),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initials.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // Title and Subtitle with Button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // 👈 prevent overflow
                        child: Text(
                          widget.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3C3B3B),
                          ),
                        ),
                      ),
                      if (widget.isShowMore == true)
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.black,
                        ),
                    ],
                  ),
                  if (widget.doctorName != null)
                    Text(
                      '${widget.doctorName}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C3B3B),
                      ),
                    ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      widget.isSentInvite!
                          ? const Text(
                              'Name: ',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.primaryColor,
                              ),
                            )
                          : !widget.isAcceptReject
                              ? const Text(
                                  'Public ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.primaryColor,
                                  ),
                                )
                              : const Text(
                                  'Invited by: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.secondryColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  if (!widget.isMember)
                    widget.isLoading
                        ? const CircularProgressIndicator() // ✅ Show loading
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              // ✅ Handle loading inside button
                              widget.onButtonPressed();
                            },
                            child: Text(
                              widget.buttonText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  if (widget.isAcceptReject)
                    widget.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              ElevatedButton(
                                onPressed: widget.isLoading
                                    ? null
                                    : widget.onAcceptedButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Accept'),
                              ),
                              ElevatedButton(
                                onPressed: widget.isLoading
                                    ? null
                                    : widget.onRejecteddButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Reject'),
                              ),
                            ],
                          )

                  // AcceptRejectButtons(
                  //   onAccept: widget.onAcceptedButtonPressed!,
                  //   onReject: widget.onRejecteddButtonPressed!,
                  //   isLoading: widget.isLoading,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
