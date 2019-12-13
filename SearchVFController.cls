public class SearchVFController {
    public list <Account> acc {get;set;}
    public String numberOfRecords {get;set;}
    public String billingCity {get;set;}
    public String billingState {get;set;}
    public String billingCountry {get;set;}
    private integer counter=0;  //keeps track of the offset
    private integer list_size=2; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
    public SearchVFController() {
         total_size = [select count() from Account];
    }
    
    public void search(){
        if(String.isBlank(numberOfRecords))
            numberOfRecords='2';
        string searchquery='select Name,Billingcity,Billingstate,billingCountry from account '
            + ' where Billingcity like \''+billingCity+'%\' '
            + ' or Billingstate like  \''+billingState+'%\' '
            + ' or billingCountry like  \''+billingCountry+'%\' '
            + ' Limit '+numberOfRecords+ ' offset '+counter;
        System.debug('searchquery--:'+searchquery);
        acc= Database.query(searchquery);
    }
    
   public PageReference Beginning() { //user clicked beginning
      counter = 0;
      return null;
   }

   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
       search();
      return null;
   }

   public PageReference Next() { //user clicked next button
      counter += list_size;
       search();
      return null;
   }

   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
       search();
      return null;
   }

   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }

   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }

   public Integer getTotal_size() {
      return total_size;
   }

   public Integer getPageNumber() {
      return counter/list_size + 1;
   }

   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }
}