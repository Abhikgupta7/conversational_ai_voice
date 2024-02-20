import "commonReactions/all.dsl";
import "insurances/all.dsl";
import "claimsInfo/all.dsl";

context
{
    // declare input variables here
    input phone: string;
    
    // declare storage variables here
    name: string = "";
    policy_number: string = "";
    policy_read: string = "";
    data_number: string = "";
    address: string = "";
    message: string = "";
    query_status: string = "";
    data_info: boolean = true;
    output receive_date: string = "";
    output process_date: string = "";
    output paid_amount: string = "";
    amount:string = "";
    amount_type:string = "";
    number_type:string = "";
}

// declare external functions here
external function convert_date(data_number: string): string;
external function convert_number(data_number: string): string;
external function convert_address(address: string): string;
external function query_status(): string;
external function find_info(): boolean;
external function amount_info(amount:string, amount_type:string):string;
external function gen_info():string;
external function all_name(name:string):string;

start node root
{
    do //actions executed in this node
    {
        #connectSafe($phone);
        // blockcall vspBlock();
        // blockcall aetnaBlock();
        // digression disable
        // {
        //     dont_understand
        // }
        // ;
        blockcall medicare_txBlock();
        // #say("greeting");
        #log("came out");
        wait *;
    }
}

digression greeting
{
    conditions
    {
        on #messageHasIntent("greeting");
    }
    do
    {
        // digression enable
        // {
        //     dont_understand
        // }
        // ;
        #sayText("I am fine. Thank you for asking.");
        wait*;
    }
}

digression rep_intro
{
    conditions
    {
        on #messageHasAnyIntent(["rep_intro", "ai_name"]);
    }
    do
    {
        // digression enable
        // {
        //     dont_understand
        // }
        // ;
        #say("greeting");
        wait*;
    }
}

// digression claims_date
// {
//     conditions
//     {
//         on #messageHasIntent("claims_date");
//     }
//     do
//     {
//         set $receive_date =  #messageGetData("receive_date")[0]?.value??"";
//         set $process_date =  #messageGetData("process_date")[0]?.value??"";
//         #sayText("So claim receive date date is " + $receive_date);
//         #sayText("So claim process date date is " + $process_date);
//         wait*;
//     }
// }

// digression received_date
// {
//     conditions
//     {
//         on #messageHasIntent("received_date");
//     }
//     do
//     {
//         set $receive_date =  #messageGetData("receive_date")[0]?.value??"";
//         #sayText("So claim receive date is " + $receive_date);
//         wait*;
//     }
// }

// digression processed_date
// {
//     conditions
//     {
//         on #messageHasIntent("processed_date");
//     }
//     do
//     {
//         set $process_date =  #messageGetData("process_date")[0]?.value??"";
//         #sayText("So claim process date is " + $process_date);
//         wait*;
//     }
// }

// digression paid_amount
// {
//     conditions
//     {
//         on #messageHasIntent("paid_amount");
//     }
//     do
//     {
//         set $amount =  #messageGetData("paid_amt")[0]?.value??"";
//         set $amount_type = "paidAmount";
//         external amount_info($amount, $amount_type);
//         wait*;
//     }
// }

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

digression assistance
{
    conditions
    {
        on #messageHasAnyIntent(["assistance","claim_assistance"]);
    }
    do
    {
        #sayText("I need general claim status. Like claim number, check details");
        // set $query_status = external query_status();
        // #say("confirm_query" ,
        // {
        //     query_status: $query_status
        // }
        // );
        // digression enable
        // {
        //     dont_understand
        // }
        // ;
        wait*;
    }
}

digression need_info
{
    conditions
    {
        on #messageHasIntent("need_info");
    }
    do
    {
        #sayText("Okay, sure. Ask me");
        wait*;
    }
}

digression hold
{
    conditions
    {
        on #messageHasIntent("hold");
    }
    do
    {
        #sayText("Yeah, sure. Take your time.");
        wait*;
    }
}

/*---------------------------Provider Information---------------------------------------------*/

digression npi_number
{
    conditions
    {
        on #messageHasIntent("npi_number");
    }
    do
    {
        set $data_number = "npi";
        set $data_number = external convert_number($data_number);
        #log("npi");
        #log($data_number);
        #say("confirm_number" ,
        {
            data_number: $data_number
        }
        );
        wait*;
    }
}

digression rendering_npi
{
    conditions
    {
        on #messageHasIntent("rendering_npi");
    }
    do
    {
        set $data_number = "rnpi";
        set $data_number = external convert_number($data_number);
        #log("rendering npi");
        #log($data_number);
        #say("confirm_number" ,
        {
            data_number: $data_number
        }
        );
        wait*;
    }
}

digression tax_id
{
    conditions
    {
        on #messageHasIntent("tax_id");
    }
    do
    {
        set $data_number = "taxId";
        set $data_number = external convert_number($data_number);
        #log("tax id");
        #log($data_number);
        #say("confirm_number" ,
        {
            data_number: $data_number
        }
        );
        wait*;
    }
}

digression office_number
{
    conditions
    {
        on #messageHasIntent("office_number");
    }
    do
    {
        set $data_number = "provider_phone";
        set $data_number = external convert_number($data_number);
        #log("office phone");
        #log($data_number);
        #say("confirm_number" ,
        {
            data_number: $data_number
        }
        );
        wait*;
    }
}

digression call_back_number
{
    conditions
    {
        on #messageHasIntent("call_back_number");
    }
    do
    {
        set $data_number = "callback_number";
        set $data_number = external convert_number($data_number);
        #log("call back number");
        #log($data_number);
        #say("confirm_number" ,
        {
            data_number: $data_number
        }
        );
        wait*;
    }
}

digression facility_name
{
    conditions
    {
        on #messageHasIntent("facility_name");
    }
    do
    {
        set $name = "facility";
        set $name = external all_name($name);
        #say("confirm_name" ,
        {
            name: $name
        }
        );
        wait*;
    }
}

digression provider_name
{
    conditions
    {
        on #messageHasIntent("provider_name");
    }
    do
    {
        set $name = "provider";
        set $name = external all_name($name);
        #say("confirm_name" ,
        {
            name: $name
        }
        );
        wait*;
    }
}

digression provider_address
{
    conditions
    {
        on #messageHasIntent("provider_address");
    }
    do
    {
        set $address = "provider_address";
        set $address = external convert_address($address);
        #sayText($address);
        wait*;
    }
}

/*---------------------------Patient Information---------------------------------------------*/

//patient's name and dob are combined together, whenever both intents are referred in one sentence
digression patient_name_dob
{
    conditions
    {
        on #messageHasIntent("patient_dob") and #messageHasIntent("patient_name");
    }
    do
    {
        // #log("ran");
        set $name = "patientName";
        set $name = external all_name($name);
        #say("confirm_name" ,
        {
            name: $name
        }
        );
        set $data_number = "patient_dob";
        set $data_number = external convert_date($data_number);
        #sayText($data_number);
        wait*;
    }
}

digression patient_name
{
    conditions
    {
        on #messageHasIntent("patient_name");
    }
    do
    {
        set $name = "patientName";
        set $name = external all_name($name);
        #say("confirm_name" ,
        {
            name: $name
        }
        );
        wait*;
    }
}

digression patient_dob
{
    conditions
    {
        on #messageHasIntent("patient_dob");
    }
    do
    {
        set $data_number = "patient_dob";
        set $data_number = external convert_date($data_number);
        #sayText($data_number);
        wait*;
    }
}

digression policy
{
    conditions
    {
        on #messageHasIntent("policy_number");
    }
    do
    {
        set $data_number = "policyNumber";
        set $data_number = external convert_number($data_number);
        #say("confirm_number" ,
        {
            data_number: $data_number
        }
        );
        wait*;
    }
}

/*---------------------------Claim Information---------------------------------------------*/

digression claim_dos
{
    conditions
    {
        on #messageHasIntent("claim_dos");
    }
    do
    {
        set $data_number = "dos";
        set $data_number = external convert_date($data_number);
        #sayText($data_number);
        #sayText("Billed amount is Two Seventy Eight Dollars");
        // digression disable
        // {
        //     dont_understand
        // }
        // ;
        wait*;
    }
}

// digression how_are_you
// {
//     conditions
//     {
//         on #messageHasIntent("how_are_you");
//     }
//     do
//     {
//         #sayText("I'm well, thank you!", repeatMode: "ignore");
//         #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node
//         return; // go back to the node from which we got distracted into the digression
//     }
// }

/*---------------------------Miscellaneous Information---------------------------------------------*/

digression anything_else
{
    conditions
    {
        on #messageHasIntent("anything_else");
    }
    do
    {
        #sayText("Can you provide me the call reference number?");
        // var ans = external gen_info();
        
        //whatever the value will be the ans or return value, according to that we go to a library
        // blockcall receiveBlock();
        // blockcall processBlock();
        // blockcall allowedBlock();
        wait*;
    }
}

// digression dont_understand
// {
//     conditions
//     {
//         on true priority -1000;
//     }
//     var retriesLimit=0;
//     var counter=0;
//     var resetOnRecognized=false;
//     // var responses: Phrases[] = ["dont_understand"];
//     do
//     {
//         #sayText("Sorry I didn't understand. Can you repeat again.");
//         wait*;
//     }
// }

digression i_am_robot
{
    conditions
    {
        on #messageHasAnyIntent(digression.i_am_robot.triggers);
    }
    var triggers = ["are_you_a_robot"];
    // var responses: Phrases[] = ["yes_i_am_a_robot"];
    do
    {
        //#repeat(accuracy: "short");
        #sayText("No.");
        wait*;
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

//---------------------------------For understanding------------------------------------------

// digression policy_1
// {
//     conditions {on #messageHasIntent("policy_check");}
//     do
//     {
//         #say("what_policy");
//         wait*;
//     }
//     transitions
//     {
//         policy_2: goto policy_2 on #messageHasData("policy");
//     }
// }

// node policy_2
// {
//     do
//     {
//         set $policy_number = #messageGetData("policy")[0]?.value??"";
//         set $policy_read = external convert_policy($policy_number);
//         #log($policy_read);
//         #say("confirm_policy" , {policy_read: $policy_read} );
//         wait*;
//     }
//     transitions
//     {
//         yes: goto policy_3 on #messageHasIntent("yes");
//         no: goto policy_1_a on #messageHasIntent("no");
//     }
// }

//used during making call to Open ai or bard

// digression claim_info
// {
//     conditions
//     {
//         on #messageHasIntent("claim_info");
//     }
//     do
//     {
//         set $message = #getMessageText();
//         set $message = external api_call($message);
//         #sayText($message);
//     }
// }

//---------------------------------For understanding------------------------------------------
