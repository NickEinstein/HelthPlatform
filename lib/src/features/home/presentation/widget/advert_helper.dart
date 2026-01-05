import 'dart:async';

import 'package:flutter/material.dart';

import 'video_player_widget.dart';

class AdvertHelper extends StatefulWidget {
  final List<AdvertModel> goals;

  const AdvertHelper({super.key, required this.goals});

  @override
  State<AdvertHelper> createState() => _AdvertHelperState();
}

class _AdvertHelperState extends State<AdvertHelper>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late Timer _autoSlideTimer;
  late AnimationController _pulseController;
  // late Animation<double> _pulseAnimation;

  // Map index -> GlobalKey to control VideoPlayerWidgets
  final Map<int, GlobalKey<VideoPlayerWidgetState>> _videoKeys = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize keys for video goals only
    for (int i = 0; i < widget.goals.length; i++) {
      if (widget.goals[i].mediaType == 'video') {
        _videoKeys[i] = GlobalKey<VideoPlayerWidgetState>();
      }
    }

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // _pulseAnimation = Tween<double>(
    //   begin: 1.0,
    //   end: 1.05,
    // ).animate(CurvedAnimation(
    //   parent: _pulseController,
    //   curve: Curves.easeInOut,
    // ));

    _autoSlideTimer =
        Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      if (!mounted) return;

      int nextIndex = _currentIndex + 1;
      if (nextIndex >= widget.goals.length) nextIndex = 0;

      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _autoSlideTimer.cancel();

    // Pause all videos before dispose
    for (final key in _videoKeys.values) {
      key.currentState?.pause();
    }

    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    // Pause previous video
    if (_videoKeys.containsKey(_currentIndex)) {
      _videoKeys[_currentIndex]?.currentState?.pause();
    }

    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.goals.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return AnimatedScale(
                scale: _currentIndex == index ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 300),
                child: _buildHealthGoalCard(widget.goals[index], index),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildHealthGoalCard(AdvertModel goal, int index) {
    Widget mediaWidget;

    if (goal.mediaType == 'video') {
      mediaWidget = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: VideoPlayerWidget(
          key: _videoKeys[index],
          videoUrl: goal.imagePath,
        ),
      );
    } else if (goal.isAsset) {
      mediaWidget = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(goal.imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    } else {
      mediaWidget = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(goal.imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          mediaWidget,
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  goal.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffF2F2F2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Model to hold data for each health goal card
class AdvertModel {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String mediaType; // 'image' or 'video'
  final bool isAsset; // true if local asset

  AdvertModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
    required this.backgroundColor,
    this.mediaType = 'image',
    this.isAsset = false,
  });
}
