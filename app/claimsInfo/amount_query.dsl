library

block allowed_queryBlock(): boolean
{
    start node root
    {
        do
        {
            #sayText("According to the details you have provided. Allowed amount is _ & paid amount is _. So can you tell where is the rest of the allowed amount applied);
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
