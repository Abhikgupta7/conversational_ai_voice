library

block processBlock(): boolean
{
    start node root
    {
        do
        {
            #sayText("Can you tell me what is the process date of the claim");
            wait*;
        }
    }
    
    digression processed_date
    {
        conditions
        {
            on #messageHasIntent("processed_date");
        }
        do
        {
            var process_date =  #messageGetData("process_date")[0]?.value??"";
            #sayText("So claim process date is " + process_date);
            return true;
        }
    }
    
    digression simple_date
    {
        conditions
        {
            on #messageHasIntent("simple_date");
        }
        do
        {
            var process_date =  #messageGetData("process_date")[0]?.value??"";
            #sayText("So claim receive date is " + process_date);
            return true;
        }
    }
}
