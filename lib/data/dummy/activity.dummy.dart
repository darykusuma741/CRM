import 'dart:math';
import 'package:crm/data/model/activity.model.dart';

class ActivityDummy {
  // 🔹 Fake summary untuk CALL
  static final List<String> _summaryCall = [
    'Intro Call with PT Sinar',
    'Follow-up After Demo',
    'Cold Call – Retail Division',
    'Post-Meeting Confirmation',
    'Qualification Call',
  ];

  static List<ActivityModel> dataCall = _summaryCall.map((summary) {
    return ActivityModel(
      id: Random().nextInt(10000),
      name: summary,
      dueDate: DateTime.now().add(Duration(days: Random().nextInt(5))),
      notes: 'Discussed solutions and gathered client requirements.',
      feedback: 'Good response, follow up next week',
      wa: "6288242286199",
      activityType: ActivityType.call,
    );
  }).toList();

  // 🔹 Fake summary untuk DOCUMENT
  static final List<String> _summaryDocument = [
    'Proposal Submission – PT Sinar Jaya',
    'Contract Draft – Retail Division',
    'Technical Specification Document',
    'Product Catalogue Update',
    'Quotation for System Upgrade',
  ];

  static List<ActivityModel> dataDocument = _summaryDocument.map((summary) {
    return ActivityModel(
      id: Random().nextInt(10000),
      name: summary,
      dueDate: DateTime.now().add(Duration(days: Random().nextInt(7))),
      notes: 'Submitted document for client review.',
      feedback: 'Pending response',
      activityType: ActivityType.document,
    );
  }).toList();

  // 🔹 Fake summary untuk MEETING
  static final List<String> _summaryMeeting = [
    'Weekly Alignment Meeting',
    'Kick-off Project Meeting',
    'Client Feedback Session',
    'Budget Review Meeting',
    'Strategy Planning Session',
  ];

  static List<ActivityModel> dataMeeting = _summaryMeeting.map((summary) {
    return ActivityModel(
      id: Random().nextInt(10000),
      name: summary,
      dueDate: DateTime.now().add(Duration(days: Random().nextInt(10))),
      notes: 'Discussed milestones, blockers, and next steps.',
      feedback: 'Positive alignment with stakeholders',
      activityType: ActivityType.meeting,
      description: 'An initial meeting to officially start the project, align team members, clarify objectives, timelines.',
    );
  }).toList();

  // 🔹 Fake summary untuk TO-DO
  static final List<String> _summaryToDo = [
    'Prepare Onboarding Materials',
    'Update Sales Pitch Deck',
    'Review Client Feedback',
    'Schedule Demo for New Leads',
    'Create Monthly Performance Report',
  ];

  static List<ActivityModel> dataToDo = _summaryToDo.map((summary) {
    return ActivityModel(
      id: Random().nextInt(10000),
      name: summary,
      dueDate: DateTime.now().add(Duration(days: Random().nextInt(14))),
      notes: 'Ensure all tasks are completed before deadline.',
      feedback: 'In progress',
      activityType: ActivityType.toDo,
    );
  }).toList();
}
