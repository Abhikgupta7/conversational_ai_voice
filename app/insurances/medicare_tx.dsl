library

block medicare_txBlock(): boolean
{
    context
    {
        number_type:string = "";
    }
    
    external function add_spaces_string(number_type:string): string[];
    external function medicare_id_conversion(): string[];
    
    start node root
    {
        do
        {
            #sayText("arrived");
            wait*;
        }
    }
    
    digression medicare_part
    {
        conditions
        {
            on #messageHasIntent("medicare_part");
        }
        do
        {
            #sendDTMF("4");
            // #sayText("B");
            wait*;
        }
    }
    
    digression medicare_state
    {
        conditions
        {
            on #messageHasIntent("medicare_state");
        }
        do
        {
            #sendDTMF("7");
            // #sayText("Texas");
            wait*;
        }
    }
    
    digression medicare_q3
    {
        conditions
        {
            on #messageHasIntent("medicare_q3");
        }
        do
        {
            #sendDTMF("2");
            // #sayText("No");
            wait*;
        }
    }
    
    digression medicare_q4
    {
        conditions
        {
            on #messageHasIntent("medicare_q4");
        }
        do
        {
            #sayText("Claim status");
            wait*;
        }
    }
    
    digression medicare_q5
    {
        conditions
        {
            on #messageHasIntent("medicare_q5");
        }
        do
        {
            //using of for loop and array
            set $number_type = "npi";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            wait*;
        }
    }
    
    digression medicare_q6
    {
        conditions
        {
            on #messageHasIntent("medicare_q6");
        }
        do
        {
            set $number_type = "ptan";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            wait*;
        }
    }
    
    digression medicare_q7
    {
        conditions
        {
            on #messageHasIntent("medicare_q7");
        }
        do
        {
            set $number_type = "taxId";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            wait*;
        }
    }
    
    digression medicare_q8
    {
        conditions
        {
            on #messageHasIntent("medicare_q8");
        }
        do
        {
            #sendDTMF("1");
            wait*;
        }
    }
    
    digression medicare_q9
    {
        conditions
        {
            on #messageHasIntent("medicare_q9");
        }
        do
        {
            #sendDTMF("1");
            wait*;
        }
    }
    
    //patient's medicare number or medicare id
    digression medicare_q10
    {
        conditions
        {
            on #messageHasIntent("medicare_q10");
        }
        do
        {
            var array: string[] = external medicare_id_conversion();
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            wait*;
        }
    }
    
    digression medicare_q11
    {
        conditions
        {
            on #messageHasIntent("medicare_q11");
        }
        do
        {
            // 243795
            #sendDTMF("7");
            #sendDTMF("3");
            #sendDTMF("2");
            #sendDTMF("8");
            #sendDTMF("6");
            #sendDTMF("6");
            #sendDTMF("2");
            #log("7328662");
            wait*;
        }
    }
    
    digression medicare_q12
    {
        conditions
        {
            on #messageHasIntent("medicare_q12");
        }
        do
        {
            set $number_type = "dos";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            wait*;
        }
    }
    
    digression aetna_exit
    {
        conditions
        {
            on #messageHasIntent("aetna_exit");
        }
        do
        {
            #sayText("No");
            return true;
        }
    }
    
    digression hangup
    {
        conditions
        {
            on true priority -1000 tags: onclosed;
        }
        do
        {
            exit;
        }
    }
    
    digression cent_payment
    {
        conditions
        {
            on #messageHasIntent("cent_payment");
        }
        do
        {
            #log("ran cent");
            wait*;
        }
    }
    
    digression double_payment
    {
        conditions
        {
            on #messageHasIntent("double_payment");
        }
        do
        {
            #log("ran double");
            wait*;
        }
    }
    
    digression triple_payment
    {
        conditions
        {
            on #messageHasIntent("triple_payment");
        }
        do
        {
            #log("ran triple");
            wait*;
        }
    }
    
    //two digit and cent
    
    digression double_cent
    {
        conditions
        {
            on #messageHasIntent("double_cent");
        }
        do
        {
            #log("ran double cent");
            wait*;
        }
    }
    
    //three digit and cent
    
    digression triple_cent
    {
        conditions
        {
            on #messageHasIntent("triple_payment") and #messageHasIntent("cent_payment");
        }
        do
        {
            #log("ran triple cent");
            wait*;
        }
    }
}
