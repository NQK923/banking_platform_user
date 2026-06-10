import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SkeletonBox extends StatefulWidget {
  final double height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;

  const SkeletonBox({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base = theme.colorScheme.surfaceContainerLow;
    final highlight = theme.colorScheme.surfaceContainerHighest;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius:
                widget.borderRadius ?? BorderRadius.circular(AppRadius.m),
            gradient: LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
              colors: [base, highlight, base],
              stops: const [0.25, 0.5, 0.75],
            ),
          ),
        );
      },
    );
  }
}

class TransactionSkeletonList extends StatelessWidget {
  final int itemCount;

  const TransactionSkeletonList({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index == itemCount - 1 ? 0 : 10),
          child: const Row(
            children: [
              SkeletonBox(
                height: 48,
                width: 48,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              SizedBox(width: AppSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(height: 14, width: 140),
                    SizedBox(height: AppSpacing.s),
                    SkeletonBox(height: 12, width: 190),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.m),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SkeletonBox(height: 14, width: 86),
                  SizedBox(height: AppSpacing.s),
                  SkeletonBox(height: 22, width: 96),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
