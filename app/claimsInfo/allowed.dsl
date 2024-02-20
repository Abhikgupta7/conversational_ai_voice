library

block allowedBlock(): boolean
{
    start node root
    {
        do
        {
            #sayText("Can you tell me what is the allowed amount of the claim");
            wait*;
        }
    }
    
    digression allowed_amount
    {
        conditions
        {
            on #messageHasIntent("allowed_amount");
        }
        do
        {
            var amount =  #messageGetData("paid_amt")[0]?.value??"";
            #sayText("So allowed amount is " + amount);
            wait*;
        }
    }
    
    digression simple_amount
    {
        conditions
        {
            on #messageHasIntent("simple_amount");
        }
        do
        {
            var amount =  #messageGetData("paid_amt")[0]?.value??"";
            #sayText("So allowed amount is " + amount);
            return true;
        }
    }
}
