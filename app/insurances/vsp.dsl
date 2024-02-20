library

block vspBlock(): boolean
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
            wait*;
        }
    }
    
    digression vsp_phone
    {
        conditions
        {
            on #messageHasIntent("vsp_phone");
        }
        do
        {
            set $number_type = "provider_phone";
            var array: string[] = external add_spaces_string($number_type);
            for (var item in array)
            {
                #log(item);
                #sendDTMF(item);
            }
            wait*;
        }
    }
    
    digression vsp_option1
    {
        conditions
        {
            on #messageHasIntent("vsp_option1");
        }
        do
        {
            #log("1");
            #sendDTMF("1");
            wait*;
        }
    }
    
    digression vsp_memberid
    {
        conditions
        {
            on #messageHasIntent("vsp_memberid");
        }
        do
        {
            #sendDTMF("5");
            #sendDTMF("3");
            #sendDTMF("4");
            #sendDTMF("1");
            #sendDTMF("2");
            #sendDTMF("7");
            #sendDTMF("4");
            #sendDTMF("6");
            #sendDTMF("#");
            
            #log("5");
            #log("3");
            #log("4");
            #log("1");
            #log("2");
            #log("7");
            #log("4");
            #log("6");
            #log("#");
            wait*;
        }
    }
    
    digression vsp_option2
    {
        conditions
        {
            on #messageHasIntent("vsp_option2");
        }
        do
        {
            #log("1");
            #sendDTMF("1");
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
