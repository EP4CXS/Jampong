import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_dash/theme/theme.dart';

class LandingActions extends StatelessWidget {
  const LandingActions({
    required this.onStartGame,
    required this.onOpenSettings,
    required this.onOpenLeaderboard,
    super.key,
  });

  final VoidCallback onStartGame;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenLeaderboard;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GameElevatedButton(
          label: 'Start Game',
          onPressed: onStartGame,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.secondary, AppColors.primary],
          ),
        ),
        const SizedBox(height: AppSpacing.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ActionChip(
              icon: Icons.tune,
              label: 'Settings',
              onPressed: onOpenSettings,
            ),
            const SizedBox(width: AppSpacing.medium),
            _ActionChip(
              icon: FontAwesomeIcons.trophy,
              label: 'Leaderboard',
              onPressed: onOpenLeaderboard,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          'Play instantly, tweak your audio, and chase the top rank.',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.onDark,
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.large,
          vertical: AppSpacing.small,
        ),
        textStyle: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
