import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support chat'),
        actions: [
          TextButton.icon(
            onPressed: state.hasSession && !state.isHandingOff
                ? onHandoff
                : null,
            icon: state.isHandingOff
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.support_agent_rounded),
            label: const Text('Human'),
          ),
        ],
      ),
      body: SafeArea(
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
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.support_agent_rounded,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: 32,
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                Text('How can we help?', style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.s),
                Text(
                  'Ask about transfer status, refunds, failed transfers, traceId, PIN safety, recipient lookup, or balance display.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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

class _SafetyReminder extends StatelessWidget {
  final String? transactionId;

  const _SafetyReminder({this.transactionId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.s,
      ),
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.45),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.s,
        runSpacing: AppSpacing.xs,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          Text(
            'Never share PIN, password, OTP, or tokens.',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (transactionId != null)
            Chip(
              visualDensity: VisualDensity.compact,
              label: Text('Transaction ${_short(transactionId!)}'),
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
        color: AppTheme.success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.m),
        border: Border.all(color: AppTheme.success.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: AppTheme.success,
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(child: Text(message, style: theme.textTheme.bodyMedium)),
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
    final color = isUser
        ? theme.colorScheme.primary
        : isAdmin
        ? theme.colorScheme.tertiaryContainer
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isUser
        ? theme.colorScheme.onPrimary
        : isAdmin
        ? theme.colorScheme.onTertiaryContainer
        : theme.colorScheme.onSurface;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          padding: const EdgeInsets.all(AppSpacing.m),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppRadius.m).copyWith(
              bottomRight: isUser ? const Radius.circular(4) : null,
              bottomLeft: isUser ? null : const Radius.circular(4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text(
                    _senderLabel(message.senderType),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: textColor.withValues(alpha: 0.72),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              Text(
                message.message,
                softWrap: true,
                style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _senderLabel(SupportSenderType senderType) {
    return switch (senderType) {
      SupportSenderType.AI => 'Assistant',
      SupportSenderType.ADMIN => 'Support',
      SupportSenderType.SYSTEM => 'System',
      SupportSenderType.USER => 'You',
    };
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.m),
        ),
        child: const SizedBox(
          width: 42,
          child: LinearProgressIndicator(minHeight: 4),
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
                child: ActionChip(
                  label: Text(action.label),
                  avatar: Icon(_iconFor(action.type), size: 18),
                  onPressed: () => onTap(action),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            child: TextField(
              controller: controller,
              enabled: enabled,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              decoration: const InputDecoration(
                hintText: 'Ask support...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: enabled ? onSend : null,
            ),
          ),
          const SizedBox(width: AppSpacing.s),
          IconButton.filled(
            tooltip: 'Send',
            onPressed: enabled ? () => onSend(controller.text) : null,
            icon: isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}
