import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:medical_center_patient/managers/account_manager.dart';
import 'package:medical_center_patient/models/medical_case_details.dart';
import 'package:medical_center_patient/models/patient_info.dart';
import 'package:medical_center_patient/pages/medical_case_messages_page/models/case_message.dart';

class MedicalCaseChatPage extends StatefulWidget {
  const MedicalCaseChatPage({
    super.key,
    required this.medicalCaseDetails,
  });

  final MedicalCaseDetails medicalCaseDetails;
  @override
  State<MedicalCaseChatPage> createState() => _MedicalCaseChatPageState();
}

class _MedicalCaseChatPageState extends State<MedicalCaseChatPage> {
  late Future<List<types.Message>> messagesFuture;
  late types.User user;
  late types.User doctor;

  List<types.Message> _messages = [];

  bool isSendingMessage = false;
  bool isFetchingMessages = false;
  late Timer updateMessagesTimer;

  @override
  void dispose() {
    updateMessagesTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    PatientInfo patientInfo = AccountManager.instance.user!;
    messagesFuture = getInitialMessages();
    user = types.User(
      id: 'p${patientInfo.id}',
      firstName: patientInfo.firstName,
    );
    doctor = types.User(
      id: 'd${widget.medicalCaseDetails.assignedDoctor!.id}',
      firstName: widget.medicalCaseDetails.assignedDoctor!.firstName,
      lastName: widget.medicalCaseDetails.assignedDoctor!.lastName,
    );
    updateMessagesTimer = Timer.periodic(5.seconds, (timer) {
      updateMessagesList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'رسائل الحالة',
        ),
      ),
      body: SizedBox.expand(
        child: CustomFutureBuilder(
          future: messagesFuture,
          builder: (context, snapshot) => Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: user,
            theme: DefaultChatTheme(
              primaryColor: primaryColor,
              inputBorderRadius: BorderRadius.zero,
              inputBackgroundColor: Colors.white,
              inputElevation: 2,
              inputTextColor: Colors.black,
              messageBorderRadius: 14.r,
              messageInsetsVertical: 10.h,
              messageInsetsHorizontal: 15.w,
            ),
            l10n: const ChatL10nAr(
              emptyChatPlaceholder: 'ما من رسائل حتى الان',
              inputPlaceholder: 'الرسالة',
            ),
            inputOptions: const InputOptions(
              sendButtonVisibilityMode: SendButtonVisibilityMode.always,
            ),
            scrollPhysics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            showUserNames: true,
            showUserAvatars: true,
          ),
        ),
      ),
    );
  }

  Future<List<types.Message>> getMessages() async {
    try {
      isFetchingMessages = true;
      int caseId = widget.medicalCaseDetails.medicalCase.id;
      List<CaseMessage> messages = await HttpService.parsedMultiGet(
        endPoint: 'medicalCases/$caseId/',
        mapper: CaseMessage.fromMap,
      );
      return convertMessageObjects(messages);
    } finally {
      isFetchingMessages = false;
    }
  }

  List<types.Message> convertMessageObjects(
      List<CaseMessage> oldFormatMessages) {
    oldFormatMessages.sort((a, b) => a.id.compareTo(b.id));
    return oldFormatMessages
        .map<types.Message>(
          (e) => types.TextMessage(
            id: e.id.toString(),
            author: e.senderIsDoctor ? doctor : user,
            text: e.message,
            createdAt: e.sentAt.millisecondsSinceEpoch,
            type: types.MessageType.text,
          ),
        )
        .toList();
  }

  Future<List<types.Message>> getInitialMessages() async {
    var result = await getMessages();
    _messages = result.reversed.toList();
    return _messages;
  }

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
  }

  void _handleSendPressed(types.PartialText message) async {
    isSendingMessage = true;
    try {
      var result = await HttpService.rawPost(
        endPoint:
            'medicalCases/${widget.medicalCaseDetails.medicalCase.id}/sendMessage/',
        body: {
          'message': message.text,
          'senderIsDoctor': false,
          'urgencyLevel': 'normal',
        },
      );
      var messagesResponse = (jsonDecode(result) as List)
          .map<CaseMessage>((e) => CaseMessage.fromMap(e))
          .toList();
      addNewMessages(
        filterNewMessages(
          convertMessageObjects(
            messagesResponse.reversed.toList(),
          ),
        ),
      );
    } finally {
      isSendingMessage = false;
    }
  }

  List<types.Message> filterNewMessages(List<types.Message> messages) {
    List<String> messageIds = _messages.map((e) => e.id).toList();
    return messages
        .where((element) => !messageIds.contains(element.id))
        .toList();
  }

  void addNewMessages(List<types.Message> messages) {
    messages.forEach(
      (element) {
        _addMessage(element);
      },
    );
    setState(() {});
  }

  Future<void> updateMessagesList() async {
    if (isSendingMessage || isFetchingMessages) return;
    var updatedList = await getMessages();
    if (isSendingMessage) return;
    addNewMessages(
      filterNewMessages(
        updatedList,
      ),
    );
  }
}
