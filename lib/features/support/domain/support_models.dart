// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum SupportSenderType { USER, AI, ADMIN, SYSTEM }

class SupportContext {
  final String? transactionId;

  const SupportContext({this.transactionId});

  Map<String, dynamic> toJson() => {
    if (transactionId != null) 'transactionId': transactionId,
  };
}

class SupportSuggestedAction {
  final String type;
  final String label;
  final String? targetId;

  const SupportSuggestedAction({
    required this.type,
    required this.label,
    this.targetId,
  });

  factory SupportSuggestedAction.fromJson(Map<String, dynamic> json) {
    return SupportSuggestedAction(
      type: json['type']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      targetId: json['targetId']?.toString(),
    );
  }
}

class SupportChatMessage {
  final String id;
  final String sessionId;
  final SupportSenderType senderType;
  final String message;
  final DateTime createdAt;

  const SupportChatMessage({
    required this.id,
    required this.sessionId,
    required this.senderType,
    required this.message,
    required this.createdAt,
  });

  factory SupportChatMessage.fromJson(Map<String, dynamic> json) {
    return SupportChatMessage(
      id: json['id']?.toString() ?? '',
      sessionId: json['sessionId']?.toString() ?? '',
      senderType: SupportSenderType.values.firstWhere(
        (value) => value.name == json['senderType']?.toString(),
        orElse: () => SupportSenderType.SYSTEM,
      ),
      message: json['message']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  factory SupportChatMessage.local({
    required String sessionId,
    required SupportSenderType senderType,
    required String message,
  }) {
    return SupportChatMessage(
      id: UniqueKey().toString(),
      sessionId: sessionId,
      senderType: senderType,
      message: message,
      createdAt: DateTime.now(),
    );
  }
}

class SupportSessionDetail {
  final String sessionId;
  final String status;
  final String topic;
  final String? relatedTransactionId;
  final List<SupportChatMessage> messages;

  const SupportSessionDetail({
    required this.sessionId,
    required this.status,
    required this.topic,
    this.relatedTransactionId,
    required this.messages,
  });

  factory SupportSessionDetail.fromJson(Map<String, dynamic> json) {
    return SupportSessionDetail(
      sessionId: json['sessionId']?.toString() ?? '',
      status: json['status']?.toString() ?? 'OPEN',
      topic: json['topic']?.toString() ?? 'GENERAL_FAQ',
      relatedTransactionId: json['relatedTransactionId']?.toString(),
      messages: (json['messages'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(SupportChatMessage.fromJson)
          .toList(),
    );
  }
}

class CreateSupportSessionResult {
  final String sessionId;
  final String status;
  final String answer;
  final List<SupportSuggestedAction> suggestedActions;

  const CreateSupportSessionResult({
    required this.sessionId,
    required this.status,
    required this.answer,
    required this.suggestedActions,
  });

  factory CreateSupportSessionResult.fromJson(Map<String, dynamic> json) {
    return CreateSupportSessionResult(
      sessionId: json['sessionId']?.toString() ?? '',
      status: json['status']?.toString() ?? 'OPEN',
      answer: json['answer']?.toString() ?? '',
      suggestedActions: (json['suggestedActions'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(SupportSuggestedAction.fromJson)
          .toList(),
    );
  }
}

class SendSupportMessageResult {
  final String messageId;
  final String answer;
  final List<SupportSuggestedAction> suggestedActions;

  const SendSupportMessageResult({
    required this.messageId,
    required this.answer,
    required this.suggestedActions,
  });

  factory SendSupportMessageResult.fromJson(Map<String, dynamic> json) {
    return SendSupportMessageResult(
      messageId: json['messageId']?.toString() ?? '',
      answer: json['answer']?.toString() ?? '',
      suggestedActions: (json['suggestedActions'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(SupportSuggestedAction.fromJson)
          .toList(),
    );
  }
}

class SupportHandoffResult {
  final String caseId;
  final String status;
  final String message;

  const SupportHandoffResult({
    required this.caseId,
    required this.status,
    required this.message,
  });

  factory SupportHandoffResult.fromJson(Map<String, dynamic> json) {
    return SupportHandoffResult(
      caseId: json['caseId']?.toString() ?? '',
      status: json['status']?.toString() ?? 'OPEN',
      message: json['message']?.toString() ?? '',
    );
  }
}
