trigger CaseCreatedTrigger on Case (after insert) {
    CaseNotificationHandler.SendCaseNotication(Trigger.new);
}