public class WorkingDays {
private static final List<Boolean> isWorkingDay;
private static final Integer workingDaysInWeek;
static {
    isWorkingDay = new List<Boolean> { true, true, true, true, true, false, false };
    workingDaysInWeek = 5;
}

private static final Date monday = Date.newInstance(1900, 1, 3);
private static Integer getDayOfWeek(Date value) {
    return Math.mod(monday.daysBetween(value), 7);
}

public static Integer getWorkingDays(Date startDate, Date endDate) {
    if(workingDaysInWeek == 0 || startDate == null || endDate == null) {
        return 0;
    } else {
        Integer difference = startDate.daysBetween(endDate);
        if(difference == 0) {
            return isWorkingDay[getDayOfWeek(startDate)] ? 1 : 0;
        } else if(workingDaysInWeek == 7) {
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