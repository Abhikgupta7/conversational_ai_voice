library

block receiveBlock(): boolean
{
    start node root
    {
        do
        {
            #sayText("Can you tell me what is the receive date of the claim");
            wait*;
        }
    }
    
    digression received_date
    {
        conditions
        {
            on #messageHasIntent("received_date");
        }
        do
        {
            var receive_date =  #messageGetData("receive_date")[0]?.value??"";
            #sayText("So claim receive date is " + receive_date);
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
            var receive_date =  #messageGetData("receive_date")[0]?.value??"";
            #sayText("So claim receive date is " + receive_date);
            return true;
        }
    }
}
