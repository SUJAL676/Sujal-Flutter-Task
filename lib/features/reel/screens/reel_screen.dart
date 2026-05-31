import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared_widgets/app_loader.dart';
import '../provider/reel_provider.dart';
import '../widgets/reel_item.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() =>
      _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  bool showLoader = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReelProvider>().fetchReels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<ReelProvider>(
        builder: (_, provider, __) {
          return Stack(
            children: [
              if (provider.reels.isNotEmpty)
                PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.reels.length,
                  onPageChanged: provider.onPageChanged,
                  itemBuilder: (_, index) {
                    return ReelItem(
                      reel: provider.reels[index],
                    );
                  },
                ),

              if (showLoader)
                AppLoader(
                  isReady: provider.isAppReady,
                  onFinished: () {
                    setState(() {
                      showLoader = false;
                    });
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}