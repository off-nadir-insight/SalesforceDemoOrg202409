@isTest
private class LeadTriggerHandlerTest {

    private static Lead generateLeadWithTitleInput(String title) {
        Lead lead = new Lead();
        lead.Company = 'Company ' + Datetime.now().getTime();
        lead.LastName = 'LastName ' + Datetime.now().getTime();
        lead.Title = title;
        return lead;
    }

    @IsTest
    private static void handleTitleNormalization_nullTitle_shouldNotModify() {
        Lead testLead = generateLeadWithTitleInput(null);

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(new List<Lead>{testLead});
        Test.stopTest();

        Assert.isNull(testLead.Title, 'Null title has been modified, unexpectedly');
    }

    @IsTest
    private static void handleTitleNormalization_emptyTitle_shouldNotModify() {
        String title = 'MadeUpTitle';
        Lead testLead = generateLeadWithTitleInput(title);
        
        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(new List<Lead>{testLead});
        Test.stopTest();

        Assert.areEqual(title, testLead.Title, 'Title changed unexpectedly, was not on list to be updated');
    }

    @isTest
    private static void handleTitleNormalization_vpTitle_shouldModifyTitles() {

        Lead testLead1 = generateLeadWithTitleInput('VP');
        Lead testLead2 = generateLeadWithTitleInput('vice-pres');
        Lead testLead3 = generateLeadWithTitleInput('V President');
        Lead testLead4 = generateLeadWithTitleInput('v.p.');
        List<Lead> testLeads = new List<Lead>{testLead1, testLead2, testLead3, testLead4};

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(testLeads);
        Test.stopTest();

        for (Lead testLead : testLeads) {
            Assert.areEqual('Vice President', testLead.Title, 'Title was not modified as expected');
        }
    }

    @isTest 
    private static void handleTitleNormalization_assistantTitle_shouldModifyTitles() {

        Lead testLead = generateLeadWithTitleInput('asstnt');

        Test.startTest();
        LeadTriggerHandler.handleTitleNormalization(new List<Lead>{testLead});
        Test.stopTest();

        Assert.areEqual('Assistant', testLead.Title, 'Title was not modified as expected');
    }
}