@isTest
public class TestWorkingDays {
    @isTest static void getWorkingDays(){ 
        Date d1 = Date.newInstance(2019, 11, 1);
        Date d2 = Date.newInstance(2019, 11, 30);
        Integer count=WorkingDays.getWorkingDays(d1,d2);
        Test.startTest();
        Test.stopTest();
        System.assertEquals(22, count);
        }
    }