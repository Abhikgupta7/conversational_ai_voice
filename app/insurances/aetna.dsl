library

block aetnaBlock(): boolean
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
            #log("arrived");
            wait*;
        }
    }
    
    digression aetna_npi
    {
        conditions
        {
            on #messageHasIntent("aetna_npi");
        }
        do
        {
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
    
    digression aetna_taxid
    {
        conditions
        {
            on #messageHasIntent("aetna_taxid");
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
    
    digression aetna_claims
    {
        conditions
        {
            on #messageHasIntent("aetna_claims");
        }
        do
        {
            #log("1");
            #sendDTMF("1");
            wait*;
        }
    }
    
    digression aetna_memberid
    {
        conditions
        {
            on #messageHasIntent("aetna_memberid");
        }
        do
        {
            set $number_type = "policyNumber";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            #waitForSpeech(12000);
            #log("1");
            #sendDTMF("1");
            wait*;
        }
    }
    
    digression aetna_dob
    {
        conditions
        {
            on #messageHasIntent("aetna_dob");
        }
        do
        {
            set $number_type = "patient_dob";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            #waitForSpeech(12000);
            #log("1");
            #sendDTMF("1");
            wait*;
        }
    }
    
    digression aetna_dos
    {
        conditions
        {
            on #messageHasIntent("aetna_dos");
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
    
    digression aetna_correct
    {
        conditions
        {
            on #messageHasIntent("aetna_correct");
        }
        do
        {
            #log("0");
            #sendDTMF("0");
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
            #log("2");
            #sendDTMF("2");
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
}
