import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLoader extends StatefulWidget {
  final bool isReady;
  final VoidCallback onFinished;

  const AppLoader({
    super.key,
    required this.isReady,
    required this.onFinished,
  });

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  bool _startedExpansion = false;

  int currentMessageIndex = 0;

  Timer? _messageTimer;

  final List<String> messages = [
    "Preparing your experience...",
    "Loading amazing content...",
    "Optimizing video playback...",
    "Crafting smooth transitions...",
    "Almost there...",
  ];

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -25,
    ).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.easeInOut,
      ),
    );

    _startMessageRotation();
  }

  void _startMessageRotation() {
    _messageTimer = Timer.periodic(
      const Duration(seconds: 2),
          (timer) {
        if (_startedExpansion || !mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          currentMessageIndex =
              (currentMessageIndex + 1) % messages.length;
        });
      },
    );
  }

  @override
  void didUpdateWidget(covariant AppLoader oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isReady && !_startedExpansion) {
      _triggerFinishAnimation();
    }
  }

  Future<void> _triggerFinishAnimation() async {
    _startedExpansion = true;

    _messageTimer?.cancel();
    _bounceController.stop();

    setState(() {});

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (mounted) {
      widget.onFinished();
    }
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F2FE),
              Color(0xFFEEF2FF),
              Color(0xFFF5F3FF),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _bounceController,
            builder: (context, child) {
              final bounceValue = _bounceController.value;

              return Stack(
                alignment: Alignment.center,
                children: [
                  if (!_startedExpansion)
                    Positioned(
                      top: 70,
                      child: Transform.scale(
                        scale: 1 - (bounceValue * 0.4),
                        child: Container(
                          width: 80,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(100),
                            color: Colors.black.withOpacity(
                              0.10 +
                                  ((1 - bounceValue) * 0.08),
                            ),
                          ),
                        ),
                      ),
                    ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(
                          0,
                          _startedExpansion
                              ? 0
                              : _bounceAnimation.value,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF6D28D9),
                                  Color(0xFF06B6D4),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF6D28D9,
                                  ).withOpacity(0.25),
                                  blurRadius: 30,
                                  spreadRadius: 2,
                                ),
                                BoxShadow(
                                  color: const Color(
                                    0xFF06B6D4,
                                  ).withOpacity(0.20),
                                  blurRadius: 40,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        transitionBuilder:
                            (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position:
                              Tween<Offset>(
                                begin: const Offset(
                                  0,
                                  0.2,
                                ),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          _startedExpansion
                              ? ""
                              : messages[
                          currentMessageIndex],
                          key: ValueKey(
                            _startedExpansion
                                ? "ready"
                                : messages[
                            currentMessageIndex],
                          ),
                          textAlign: TextAlign.center,
                          style:  GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// class AppLoader extends StatefulWidget {
//   final bool isReady;
//   final VoidCallback onFinished;
//
//   const AppLoader({
//     super.key,
//     required this.isReady,
//     required this.onFinished,
//   });
//
//   @override
//   State<AppLoader> createState() => _AppLoaderState();
// }
//
// class _AppLoaderState extends State<AppLoader>
//     with TickerProviderStateMixin {
//   late AnimationController _bounceController;
//   late AnimationController _expandController;
//
//   late Animation<double> _bounceAnimation;
//
//   bool _startedExpansion = false;
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _bounceController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     )..repeat(reverse: true);
//
//     _expandController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _bounceAnimation = Tween<double>(
//       begin: 0,
//       end: -25,
//     ).animate(
//       CurvedAnimation(
//         parent: _bounceController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     _expandController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         widget.onFinished();
//       }
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant AppLoader oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     if (widget.isReady && !_startedExpansion) {
//       _startedExpansion = true;
//
//       _bounceController.stop();
//
//       _expandController.forward();
//     }
//   }
//
//   @override
//   void dispose() {
//     _bounceController.dispose();
//     _expandController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//
//     /// Screen diagonal
//     final diagonal = math.sqrt(
//       (screenSize.width * screenSize.width) +
//           (screenSize.height * screenSize.height),
//     );
//
//     return IgnorePointer(
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFE0F2FE),
//               Color(0xFFEEF2FF),
//               Color(0xFFF5F3FF),
//             ],
//           ),
//         ),
//         child: Center(
//           child: AnimatedBuilder(
//             animation: Listenable.merge([
//               _bounceController,
//               _expandController,
//             ]),
//             builder: (context, child) {
//               return Transform.translate(
//                 offset: Offset(
//                   0,
//                   _startedExpansion
//                       ? 0
//                       : _bounceAnimation.value,
//                 ),
//                 child: Transform.scale(
//                   scale: _startedExpansion
//                       ? Tween<double>(
//                     begin: 1,
//                     end: diagonal / 25,
//                   ).evaluate(_expandController)
//                       : 1,
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFF6D28D9),
//                             Color(0xFF06B6D4),
//                           ],
//                         ),
//
//                       )
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AppLoader extends StatefulWidget {
//   final bool isReady;
//   final VoidCallback onFinished;
//
//   const AppLoader({
//     super.key,
//     required this.isReady,
//     required this.onFinished,
//   });
//
//   @override
//   State<AppLoader> createState() => _AppLoaderState();
// }
//
// class _AppLoaderState extends State<AppLoader>
//     with TickerProviderStateMixin {
//   late AnimationController _bounceController;
//   late AnimationController _expandController;
//
//   late Animation<double> _bounceAnimation;
//   late Animation<double> _expandAnimation;
//
//   bool _startedExpansion = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _bounceController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     )..repeat(reverse: true);
//
//     _expandController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//
//     _bounceAnimation = Tween<double>(
//       begin: 0,
//       end: -30,
//     ).animate(
//       CurvedAnimation(
//         parent: _bounceController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     _expandAnimation = Tween<double>(
//       begin: 50,
//       end: 5000,
//     ).animate(
//       CurvedAnimation(
//         parent: _expandController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     _expandController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         widget.onFinished();
//       }
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant AppLoader oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     if (widget.isReady && !_startedExpansion) {
//       _startedExpansion = true;
//
//       _bounceController.stop();
//
//       _expandController.forward();
//     }
//   }
//
//   @override
//   void dispose() {
//     _bounceController.dispose();
//     _expandController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       child: Container(
//         color: Colors.black,
//         child: Center(
//           child: AnimatedBuilder(
//             animation: Listenable.merge([
//               _bounceController,
//               _expandController,
//             ]),
//             builder: (context, child) {
//               return Transform.translate(
//                 offset: Offset(
//                   0,
//                   _startedExpansion
//                       ? 0
//                       : _bounceAnimation.value,
//                 ),
//                 child: Container(
//                   width: _startedExpansion
//                       ? _expandAnimation.value
//                       : 50,
//                   height: _startedExpansion
//                       ? _expandAnimation.value
//                       : 50,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }