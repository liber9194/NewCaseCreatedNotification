public class CaseNotificationHandler {
    public static void SendCaseNotication(List<Case> cases) {

        CustomNotificationType type = [SELECT Id,DeveloperName FROM CustomNotificationType WHERE DeveloperName = 'NewAccountCaseCreated'];
        Messaging.CustomNotification customNotificationObj = new Messaging.CustomNotification();

        customNotificationObj.setTitle('고객사에서 새 문의를 등록했습니다.');
        customNotificationObj.setBody('고객사에서 새 문의를 등록했습니다.');
        customNotificationObj.setNotificationTypeId(type.id);

        for(Case c : cases)
        {
            List<AccountTeamMember> teamMembers = [SELECT UserId
                                                        FROM AccountTeamMember
                                                        WHERE AccountId = :c.AccountId];

            customNotificationObj.setTargetId(c.Id);

            for(AccountTeamMember teamMember : teamMembers)
            {
                try
                {
                    customNotificationObj.send(new Set<String> {teamMember.UserId});
                }
                catch(Exception e)
                {
                    System.debug('error ' + e.getMessage());
                }
            }
        }
    }
}