public with sharing class LeadTriggerHandler {
    private static List<String> vpTitlesToNormalize = new List<String>{'vp', 'v.p.', 'v-p', 'v.p', 'vice pres', 'vice-pres', 'vpres', 'v-pres', 'v president', 'vpres', 'vpotc', 'vpc'};
    private static List<String> managerTitlesToNormalize = new List<String>{'dm', 'dept mgr', 'dept. mgr', 'dpt mgr', 'dpt. mgr', 'dept manager', 'dpt manager', 'dpt. manager', 'dep mgr', 'dep. mgr', 'dep manager', 'dep. manager', 'dept head', 'dpt head', 'dep head'};
    private static List<String> executiveTitlesToNormalize = new List<String>{'exec', 'exe', 'ex', 'exec.', 'exe.', 'ex.', 'exect', 'execv', 'execu', 'exctv', 'exct', 'chief'};
    private static List<String> assistantTitlesToNormalize = new List<String>{'assist', 'asst', 'asst.', 'as.', 'asstnt', 'a.', 'assistant', 'assist.', 'asstn', 'as.', 'assistnt', 'a', 'jr'};
    
    public static void handleTitleNormalization(List<Lead> leadsToNormalize) {
        for (Lead lead : leadsToNormalize) {
            if (lead.Title == null) {
                return;
            } else if (vpTitlesToNormalize.contains(lead.Title.toLowerCase())) {
                lead.Title = 'Vice President';
            } else if (managerTitlesToNormalize.contains(lead.Title.toLowerCase())) {
                lead.Title = 'Manager';
            } else if (executiveTitlesToNormalize.contains(lead.Title.toLowerCase())) {
                lead.Title = 'Executive';
            } else if (assistantTitlesToNormalize.contains(lead.Title.toLowerCase())) {
                lead.Title = 'Assistant';
            }
        }
    }
}