@isTest
public class TestWorkingDays {
    @isTest static void testWorkingDays(){ 
        Date d1 = Date.newInstance(2019, 11, 1);
        Date d2 = Date.newInstance(2019, 11, 30);
        Integer count=WorkingDays.getWorkingDays(d1,d2);
        System.assertEquals(22, count);
        Date d3 = Date.newInstance(2019, 11, 1);
        Date d4 = Date.newInstance(2019, 11, 1);
        Integer count2=WorkingDays.getWorkingDays(d3,d4);
        System.assertEquals(1, count2);
        Date d5 = null;
        Date d6 = Date.newInstance(2019, 11, 2);
        Integer count3=WorkingDays.getWorkingDays(d5,d6);
         System.assertEquals(0, count3);
        }
    }
