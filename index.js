const dasha = require("@dasha.ai/sdk");
const { v4: uuidv4 } = require("uuid");
const express = require("express");
const cors = require("cors");

const wordToNumber = {
  'zero': 0,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
  'ten': 10,
  'eleven': 11,
  'twelve': 12,
  'thirteen': 13,
  'fourteen': 14,
  'fifteen': 15,
  'sixteen': 16,
  'seventeen': 17,
  'eighteen': 18,
  'nineteen': 19,
  'twenty': 20,
  'thirty': 30,
  'forty': 40,
  'fifty': 50,
  'sixty': 60,
  'seventy': 70,
  'eighty': 80,
  'ninety': 90
};

const months = {
  "01": "January", "02": "February", "03": "March", "04": "April",
  "05": "May", "06": "June", "07": "July", "08": "August",
  "09": "September", "10": "October", "11": "November", "12": "December"
};

const numberToWords = {
  "01": "One", "02": "Two", "03": "Three", "04": "Four", "05": "Five",
  "06": "Six", "07": "Seven", "08": "Eight", "09": "Nine", "10": "Ten",
  "11": "Eleven", "12": "Twelve", "13": "Thirteen", "14": "Fourteen", "15": "Fifteen",
  "16": "Sixteen", "17": "Seventeen", "18": "Eighteen", "19": "Nineteen", "20": "Twenty",
  "21": "Twenty One", "22": "Twenty Two", "23": "Twenty Three", "24": "Twenty Four", "25": "Twenty Five",
  "26": "Twenty Six", "27": "Twenty Seven", "28": "Twenty Eight", "29": "Twenty Nine", "30": "Thirty", "31": "Thirty One",
  "78": "Seventy Eight", "55": "Fifty Five"
};

//using this for address converison
const words = {
  0: "Zero",
  1: "One",
  2: "Two",
  3: "Three",
  4: "Four",
  5: "Five",
  6: "Six",
  7: "Seven",
  8: "Eight",
  9: "Nine",
};


//variables for storing cms data

//amount related variables
var totalAmount = "";
var allowedAmount = "";
var paidAmount = "";
var deductibleAmount = "";
var patientResponsibility = "";
var copay = "";
var coinsurance = "";
var checkAmount = "";

//date related varibales

//patient information
var policyNumber = "4UH5Y65CD87";
var patientName = "Cheryl Seaton";
var patient_dob = "06291955";
var query_status = "claim status";
// var insuredId = "";
// var rnpi = "";


//provider information
var facility = "xx";
var provider = "xx";
var npi = "xx";
var rnpi = "xx";
var ptan = "xx";
var taxId = "xx";
var provider_address = "xx";
var provider_phone = "xx";
var callback_number = "xx";


//claim information
var dos = "09152023";
var billedamt = "278"

// var faxNumber = "";
// var providerPhone = "";

//storing varibales
var id = ""

const expressApp = express();
expressApp.use(express.json());
expressApp.use(cors());


const main = async () => {
  const app = await dasha.deploy("./app");

  console.log("----app--------", app)


  //----------for entering data in IVR

  app.setExternal("all_name", async (data, conv) => {
    if (data.name == "facility") id = facility;
    else if (data.name == "provider") id = provider;
    else if (data.name == "patientName") id = patientName;
    else if (data.name == "provider_address") id = provider_address;
    return id;
  })

  //IVR
  app.setExternal("add_spaces_string", async (data, conv) => {
    if (data.number_type == "npi") id = npi;
    else if (data.number_type == "taxId") id = taxId;
    else if (data.number_type == "ptan") id = ptan;
    else if (data.number_type == "dos") id = dos;
    else if (data.number_type == "policyNumber") id = policyNumber;
    else if (data.number_type == "patient_dob") id = patient_dob;
    else if (data.number_type == "provider_phone") id = provider_phone;
    var myArray = Array.from(id);

    return myArray;
  })

  app.setExternal("convert_number", (data, conv) => {
    // var id = ""
    console.log("---------", data.data_number);
    if (data.data_number == "npi") id = npi;
    else if (data.data_number == "policyNumber") id = policyNumber;
    // else if (data == "insuredId") id = insuredId;
    else if (data.data_number == "rnpi") id = rnpi; //rendering provider npi
    else if (data.data_number == "taxId") id = taxId;
    // else if (data == "faxNumber") id = faxNumber;
    else if (data.data_number == "provider_phone") id = provider_phone;
    else if (data.data_number == "callback_number") id = callback_number;
    // else if (data == "zipCode") id = zipCode;
    // else if (data == "patientPhone") id = patientPhone;
    var num = id.split("").join(". ");
    return num;
  });

  app.setExternal("convert_date", (data, conv) => {
    if (data.data_number == "patient_dob") id = patient_dob;
    else if (data.data_number == "dos") id = dos;

    var date = months[id.substring(0, 2)] + " " + numberToWords[id.substring(2, 4)] + " " + numberToWords[id.substring(4, 6)] + " " + numberToWords[id.substring(6)]
    return date;
  });

  app.setExternal("convert_address", (data, conv) => {
    if (data.address == "provider_address") id = provider_address;
    const separatedAddress = id.replace(/\d+/g, (match) => {
      return match.split('').map(digit => words[digit]).join(' ');
    });
    return separatedAddress;
  });

  app.setExternal("gen_info", async (data, conv) => {
    if (totalAmount == 0) {

    }
    else if (allowedAmount == "") return allowedAmount;
    else if (paidAmount == "") return paidAmount;
    return "found";
  })



  app.setExternal("amount_info", async (data, conv) => {
    console.log("data---------", data.amount)
    // var number = Number(data.amount.replace(/[^0-9.-]+/g, ""));
    // if (data.amount_type == "allowedAmount") {
    //   if (totalAmount == "") totalAmount = number;
    //   else totalAmount = totalAmount + number;
    //   allowedAmount = number;
    // }
    // else if (data.amount_type == "paidAmount") {
    //   if (totalAmount == "") totalAmount = 0 - number;
    //   else totalAmount = totalAmount - number;
    //   paidAmount = number;
    // }
    // console.log(number);
    // return "found";
    let lowerCaseString = data.amount.toLowerCase();
    const words = lowerCaseString.split(' ');

    let dollars = 0;
    let cents = 0;

    let count = 0;
    // Convert words to number for dollars
    for (let i = 0; i < words.length; i++) {
      count++;
      if (words[i] === 'dollars' || words[i] === 'dollar') {
        break;
      }
      dollars += wordToNumber[words[i]];
    }

    for (let i = count; i < words.length; i++) {
      if (words[i] === 'cents' || words[i] === 'cent') {
        break;
      }
      if (wordToNumber[words[i]] == null) continue;
      cents += wordToNumber[words[i]];
    }

    // Combine dollars and cents and format the output
    const amount = dollars + cents / 100;
    console.log(amount);
    console.log(amount.toFixed(2));
    return `${amount.toFixed(2)}`;

  })

  app.setExternal("query_status", (args, conv) => {
    return query_status;
  })



  app.setExternal("medicare_id_conversion", async (data, conv) => {
    const mapping = {
      A: 21, B: 22, C: 23,
      D: 31, E: 32, F: 33,
      G: 41, H: 42, I: 43,
      J: 51, K: 52, L: 53,
      M: 61, N: 62, O: 63,
      P: 71, Q: 11, R: 72, S: 73,
      T: 81, U: 82, V: 83,
      W: 91, X: 92, Y: 93, Z: 94
    };

    const inputString = policyNumber;
    let numericForm = "";

    for (let char of inputString) {
      if (mapping[char]) {
        numericForm += `*${mapping[char]}`;
      } else {
        numericForm += char;
      }
    }
    var myArray = Array.from(numericForm);
    return myArray;
  })

  // External function check status
  app.setExternal("find_info", (args, conv) => {
    return 1;
    // const cmsData = async (req, res) => {

    //   try {
    //     const cms = await CMS.find().sort({ createdAt: -1 })
    //     // res.status(200).json(post)
    //     console.log("data", cms[0]);
    //     policyNumber = cms[0].policyNumber
    //     patientName = cms[0].patientName
    //     patientDOB = cms[0].patientDOB
    //     // query_status = cms[0].query_status //this tells we need claim status or denial or void or anything else

    //     return true
    //   }
    //   catch (error) {
    //     res.status(400).json({ error: error.message })
    //   }
    // }
    // return cmsData();
  })

  await app.start();

  console.log("-------app start--------", app.start());

  //routes

  expressApp.post("/call", async (req, res) => {
    const { phone, name } = req.body;
    // console.log("Start call for", req.body);
    res.sendStatus(200);

    console.log("Start call for", req.body);
    const conv = app.createConversation({ phone, name });
    console.log(conv)
    // conv.on("transcription", console.log);
    // conv.audio.stt = "default";
    // conv.audio.tts = "default";
    // conv.audio.noiseVolume = 0;
    // conv.audio.vadPauseDelay = 2;

    await conv.execute();
  });

  expressApp.post("/cms", async (req, res) => {
    return 1;
    // const user_id = req.user._id
    // try {
    //   const cms = await CMS.create(
    //     {
    //       policyNumber: req.body.policy,
    //       patientName: req.body.patientName,
    //       patientDOB: req.body.patientDOB,
    //     }
    //   )
    //   console.log("data", cms)
    //   res.status(200).json(cms)
    // }
    // catch (error) {
    //   res.status(400).json({ error: error.message })
    // }
  });

  const server = expressApp.listen(3000, () => {
    console.log("Api started on port 3000.");
  });


  process.on("SIGINT", () => server.close());
  server.once("close", async () => {
    await app.stop();
    app.dispose();
  });
};


main();
