public class WorkingDays{
    public static Integer getWorkingDays(Date startDate, Date endDate) {
    if(workingDaysInWeek == 0 || startDate == null || endDate == null) {
        return 0;
    } else {
        Integer difference = startDate.daysBetween(endDate);
        if(difference == 0) {
            //If the 2 dates are the same day check if the day is a working day or not
            return isWorkingDay[getDayOfWeek(startDate)] ? 1 : 0;
        } else if(workingDaysInWeek == 7) {
            //when every day is a working day return the difference
            return difference;
        } else {
            Integer wholeWeeks = Math.floor(difference / 7).intValue();
            Integer workingDays = wholeWeeks * workingDaysInWeek;
            Integer dayOfWeek = getDayOfWeek(endDate);
            for(Integer remainder = Math.mod(difference, 7); remainder >= 0; remainder--) {
                if(isWorkingDay[dayOfWeek]) {
                    workingDays++;
                }
                dayOfWeek--;
                if(dayOfWeek < 0) {
                    dayOfWeek = 6;
                }
            }
            return workingDays;
        }
    }
}   
}