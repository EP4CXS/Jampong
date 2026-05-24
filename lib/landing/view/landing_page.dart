import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_dash/game_intro/game_intro.dart';
import 'package:super_dash/gen/assets.gen.dart';
import 'package:super_dash/landing/widgets/widgets.dart';
import 'package:super_dash/leaderboard/leaderboard.dart';
import 'package:super_dash/procedural/procedural.dart';
import 'package:super_dash/settings/settings.dart';
import 'package:super_dash/theme/theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: context.isSmall
                ? Assets.images.introBackgroundMobile.provider()
                : Assets.images.introBackgroundDesktop.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xLarge),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xLarge),
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: .74),
                  borderRadius: BorderRadius.circular(AppRadii.xLarge),
                  border: Border.all(color: AppColors.outline),
                  boxShadow: AppShadows.soft,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LandingHero(),
                    const SizedBox(height: AppSpacing.xLarge),
                    LandingActions(
                      onStartGame: () {
                        drawMenu();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) => const GameIntroPage(),
                          ),
                        );
                      },
                      onOpenSettings: () => _showSettingsSheet(context),
                      onOpenLeaderboard: () => Navigator.of(context).push(
                        LeaderboardPage.route(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSettingsSheet(BuildContext context) {
    final settings = context.read<SettingsController>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.xLarge),
        ),
      ),
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings', style: textTheme.headlineSmall),
                const SizedBox(height: AppSpacing.small),
                Text(
                  'Customize your audio experience before the run.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.medium),
                ValueListenableBuilder<bool>(
                  valueListenable: settings.muted,
                  builder: (_, value, __) => SwitchListTile(
                    value: value,
                    activeThumbColor: AppColors.accent,
                    title: const Text('Mute All Audio'),
                    onChanged: (_) => settings.toggleMuted(),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: settings.musicOn,
                  builder: (_, value, __) => SwitchListTile(
                    value: value,
                    activeThumbColor: AppColors.accent,
                    title: const Text('Music'),
                    onChanged: (_) => settings.toggleMusicOn(),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: settings.soundsOn,
                  builder: (_, value, __) => SwitchListTile(
                    value: value,
                    activeThumbColor: AppColors.accent,
                    title: const Text('Sound Effects'),
                    onChanged: (_) => settings.toggleSoundsOn(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
