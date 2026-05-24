import 'package:flutter/material.dart';
import 'package:super_dash/gen/assets.gen.dart';
import 'package:super_dash/theme/theme.dart';

class LandingHero extends StatelessWidget {
  const LandingHero({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: .75),
            borderRadius: BorderRadius.circular(AppRadii.xLarge),
            border: Border.all(color: AppColors.outline),
            boxShadow: AppShadows.soft,
          ),
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Assets.images.dashWins.image(fit: BoxFit.contain),
        ),
        const SizedBox(height: AppSpacing.xLarge),
        Text(
          'Jump Mong',
          textAlign: TextAlign.center,
          style: textTheme.displayMedium,
        ),
        const SizedBox(height: AppSpacing.medium),
        Text(
          'A modern endless runner where quick reflexes,\n'
          'smart jumps, and clean runs set your best score.',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
