import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/error_view.dart';
import '../domain/support_chat_provider.dart';
import '../domain/support_models.dart';

class SupportChatScreen extends ConsumerStatefulWidget {
  final String? sessionId;
  final String? transactionId;

  const SupportChatScreen({super.key, this.sessionId, this.transactionId});

  @override
  ConsumerState<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends ConsumerState<SupportChatScreen> {
  late final TextEditingController _controller;
  late final SupportChatArgs _args;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _args = SupportChatArgs(
      sessionId: widget.sessionId,
      transactionId: widget.transactionId,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportChatProvider(_args));
    final notifier = ref.read(supportChatProvider(_args).notifier);

    return SupportChatView(
      state: state,
      controller: _controller,
      onSend: (message) {
        _controller.clear();
        notifier.send(message);
      },
      onRetry: notifier.loadSession,
      onHandoff: notifier.requestHandoff,
      onSuggestedAction: (action) => _handleSuggestedAction(context, action),
    );
  }

  void _handleSuggestedAction(
    BuildContext context,
    SupportSuggestedAction action,
  ) {
    switch (action.type) {
      case 'OPEN_TRANSACTION_DETAIL':
        final targetId = action.targetId;
        if (targetId != null && targetId.isNotEmpty) {
          context.push('/transactions/$targetId');
        }
      case 'OPEN_PIN_SETTINGS':
      case 'OPEN_SECURITY_SETTINGS':
        context.go('/profile');
      case 'CONTACT_HUMAN_SUPPORT':
        ref.read(supportChatProvider(_args).notifier).requestHandoff();
      default:
        break;
    }
  }
}

class SupportChatView extends StatelessWidget {
  final SupportChatState state;
  final TextEditingController controller;
  final ValueChanged<String> onSend;
  final VoidCallback onRetry;
  final VoidCallback onHandoff;
  final ValueChanged<SupportSuggestedAction> onSuggestedAction;

  const SupportChatView({
    super.key,
    required this.state,
    required this.controller,
    required this.onSend,
    required this.onRetry,
    required this.onHandoff,
    required this.onSuggestedAction,
  });

  @override
  Widget build(BuildContext context) {
    final canSend = !state.isSending && !state.isLoading;
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.supportChat),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.s),
            child: TextButton.icon(
              onPressed: state.hasSession && !state.isHandingOff
                  ? onHandoff
                  : null,
              icon: state.isHandingOff
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.support_agent_rounded, size: 18),
              label: Text(
                l10n.human,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [theme.colorScheme.surfaceContainerLowest, theme.colorScheme.surfaceContainerLow]
                : [const Color(0xFFFFFDFB), const Color(0xFFF6F5FC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _SafetyReminder(transactionId: state.transactionId),
              if (state.handoffMessage != null)
                _HandoffBanner(message: state.handoffMessage!),
              Expanded(
                child: _ConversationBody(state: state, onRetry: onRetry),
              ),
              if (state.suggestedActions.isNotEmpty)
                _SuggestedActions(
                  actions: state.suggestedActions,
                  onTap: onSuggestedAction,
                ),
              _MessageComposer(
                controller: controller,
                enabled: canSend,
                isSending: state.isSending,
                onSend: onSend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationBody extends StatelessWidget {
  final SupportChatState state;
  final VoidCallback onRetry;

  const _ConversationBody({required this.state, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.errorMessage != null && state.messages.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: ErrorView(error: state.errorMessage!, onRetry: onRetry),
      );
    }
    if (state.messages.isEmpty) {
      return const _SupportEmptyState();
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.m,
        AppSpacing.l,
        AppSpacing.l,
      ),
      itemCount: state.messages.length + (state.isSending ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.messages.length) {
          return const _TypingBubble();
        }
        return SupportChatMessageBubble(message: state.messages[index]);
      },
    );
  }
}

class _SupportEmptyState extends StatelessWidget {
  const _SupportEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.l),
          const _MascotIllustration(),
          const SizedBox(height: AppSpacing.xl),
          Text(
            context.l10n.howCanWeHelp,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            context.l10n.supportEmptyMessage,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MascotIllustration extends StatelessWidget {
  const _MascotIllustration();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            left: 80,
            top: 20,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 4 * math.sin(value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text('👋', style: TextStyle(fontSize: 12)),
              ),
            ),
          ),
          Positioned(
            right: 80,
            bottom: 25,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -4 * math.sin(value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF8A65),
                ),
                child: const Icon(Icons.star_rounded, size: 12, color: Colors.white),
              ),
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.4 : 0.25),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.support_agent_rounded,
                size: 44,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyReminder extends StatelessWidget {
  final String? transactionId;

  const _SafetyReminder({this.transactionId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.12)
            : theme.colorScheme.primaryContainer.withValues(alpha: 0.45),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.s,
        runSpacing: AppSpacing.xs,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 15,
            color: theme.colorScheme.primary,
          ),
          Text(
            context.l10n.safetyReminder,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (transactionId != null)
            Chip(
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99),
              ),
              backgroundColor: theme.colorScheme.surface,
              side: BorderSide(color: theme.colorScheme.outlineVariant),
              label: Text(
                context.l10n.transactionShort(_short(transactionId!)),
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _short(String value) {
    if (value.length <= 12) return value;
    return '${value.substring(0, 8)}...${value.substring(value.length - 4)}';
  }
}

class _HandoffBanner extends StatelessWidget {
  final String message;

  const _HandoffBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.m,
        AppSpacing.l,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppTheme.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(color: AppTheme.success.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: AppTheme.success,
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SupportChatMessageBubble extends StatelessWidget {
  final SupportChatMessage message;

  const SupportChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.senderType == SupportSenderType.USER;
    final isAdmin = message.senderType == SupportSenderType.ADMIN;
    final isDark = theme.brightness == Brightness.dark;

    final decoration = isUser
        ? BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.l).copyWith(
              bottomRight: const Radius.circular(4),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          )
        : BoxDecoration(
            color: isDark
                ? (isAdmin ? theme.colorScheme.tertiaryContainer : theme.colorScheme.surfaceContainer)
                : (isAdmin ? theme.colorScheme.tertiaryContainer : Colors.white),
            borderRadius: BorderRadius.circular(AppRadius.l).copyWith(
              bottomLeft: const Radius.circular(4),
            ),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: isDark ? 0.08 : 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          );

    final textColor = isUser
        ? theme.colorScheme.onPrimary
        : (isAdmin ? theme.colorScheme.onTertiaryContainer : theme.colorScheme.onSurface);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.l,
            vertical: AppSpacing.m,
          ),
          decoration: decoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text(
                    _senderLabel(context, message.senderType),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: textColor.withValues(alpha: 0.72),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              Text(
                message.message,
                softWrap: true,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: isUser ? FontWeight.w600 : null,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _senderLabel(BuildContext context, SupportSenderType senderType) {
    final l10n = context.l10n;
    return switch (senderType) {
      SupportSenderType.AI => l10n.assistant,
      SupportSenderType.ADMIN => l10n.support,
      SupportSenderType.SYSTEM => l10n.systemSender,
      SupportSenderType.USER => l10n.you,
    };
  }
}

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
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
    final dotColor = theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m - 2,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.m).copyWith(
            bottomLeft: const Radius.circular(4),
          ),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final delay = index * 0.2;
                final normalizedValue = (_controller.value - delay) % 1.0;
                final double value;
                if (normalizedValue < 0.5) {
                  value = -math.sin(normalizedValue * 2 * math.pi);
                } else {
                  value = 0.0;
                }
                final offset = value * 4.0;

                return Transform.translate(
                  offset: Offset(0, offset),
                  child: Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

class _SuggestedActions extends StatelessWidget {
  final List<SupportSuggestedAction> actions;
  final ValueChanged<SupportSuggestedAction> onTap;

  const _SuggestedActions({required this.actions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.s,
      ),
      child: Row(
        children: actions
            .map(
              (action) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.s),
                child: Theme(
                  data: theme.copyWith(
                    chipTheme: theme.chipTheme.copyWith(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                      ),
                    ),
                  ),
                  child: ActionChip(
                    label: Text(
                      action.label,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    avatar: Icon(_iconFor(action.type), size: 16),
                    onPressed: () => onTap(action),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  IconData _iconFor(String type) {
    return switch (type) {
      'OPEN_TRANSACTION_DETAIL' => Icons.receipt_long_rounded,
      'OPEN_PIN_SETTINGS' => Icons.password_rounded,
      'OPEN_SECURITY_SETTINGS' => Icons.security_rounded,
      'CONTACT_HUMAN_SUPPORT' => Icons.support_agent_rounded,
      _ => Icons.arrow_forward_rounded,
    };
  }
}

class _MessageComposer extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final bool isSending;
  final ValueChanged<String> onSend;

  const _MessageComposer({
    required this.controller,
    required this.enabled,
    required this.isSending,
    required this.onSend,
  });

  void _submit(BuildContext context) {
    final value = controller.value;
    if (value.composing.isValid && !value.composing.isCollapsed) {
      FocusScope.of(context).unfocus();
      return;
    }
    final text = value.text.trim();
    if (text.isEmpty) return;
    onSend(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.s,
        AppSpacing.l,
        AppSpacing.s + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Theme(
              data: theme.copyWith(
                inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.l,
                    vertical: AppSpacing.m,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              child: TextField(
                controller: controller,
                enabled: enabled,
                minLines: 1,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  hintText: l10n.askSupport,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.s),
          IconButton.filled(
            tooltip: l10n.sendMessage,
            onPressed: enabled ? () => _submit(context) : null,
            icon: isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.send_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}
