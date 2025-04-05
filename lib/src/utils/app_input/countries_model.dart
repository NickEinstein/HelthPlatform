// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

final countries = countryModelFromJson(countriesJson);

const countriesJson = """{
  "error": false,
  "message": "All available countries",
  "data": [
    {
      "country": "Nigeria",
      "dial_code": "234",
      "short_code": "NG"
    },
    {
      "country": "Albania",
      "dial_code": "355",
      "short_code": "AL"
    },
    {
      "country": "Algeria",
      "dial_code": "213",
      "short_code": "DZ"
    },
    {
      "country": "AmericanSamoa",
      "dial_code": "1684",
      "short_code": "AS"
    },
    {
      "country": "Andorra",
      "dial_code": "376",
      "short_code": "AD"
    },
    {
      "country": "Angola",
      "dial_code": "244",
      "short_code": "AO"
    },
    {
      "country": "Anguilla",
      "dial_code": "1264",
      "short_code": "AI"
    },
    {
      "country": "Antarctica",
      "dial_code": "672",
      "short_code": "AQ"
    },
    {
      "country": "Antigua and Barbuda",
      "dial_code": "1268",
      "short_code": "AG"
    },
    {
      "country": "Argentina",
      "dial_code": "54",
      "short_code": "AR"
    },
    {
      "country": "Armenia",
      "dial_code": "374",
      "short_code": "AM"
    },
    {
      "country": "Aruba",
      "dial_code": "297",
      "short_code": "AW"
    },
    {
      "country": "Australia",
      "dial_code": "61",
      "short_code": "AU"
    },
    {
      "country": "Austria",
      "dial_code": "43",
      "short_code": "AT"
    },
    {
      "country": "Azerbaijan",
      "dial_code": "994",
      "short_code": "AZ"
    },
    {
      "country": "Bahamas",
      "dial_code": "1242",
      "short_code": "BS"
    },
    {
      "country": "Bahrain",
      "dial_code": "973",
      "short_code": "BH"
    },
    {
      "country": "Bangladesh",
      "dial_code": "880",
      "short_code": "BD"
    },
    {
      "country": "Barbados",
      "dial_code": "1246",
      "short_code": "BB"
    },
    {
      "country": "Belarus",
      "dial_code": "375",
      "short_code": "BY"
    },
    {
      "country": "Belgium",
      "dial_code": "32",
      "short_code": "BE"
    },
    {
      "country": "Belize",
      "dial_code": "501",
      "short_code": "BZ"
    },
    {
      "country": "Benin",
      "dial_code": "229",
      "short_code": "BJ"
    },
    {
      "country": "Bermuda",
      "dial_code": "1441",
      "short_code": "BM"
    },
    {
      "country": "Bhutan",
      "dial_code": "975",
      "short_code": "BT"
    },
    {
      "country": "Plurinational State of Bolivia",
      "dial_code": "591",
      "short_code": "BO"
    },
    {
      "country": "Bosnia and Herzegovina",
      "dial_code": "387",
      "short_code": "BA"
    },
    {
      "country": "Botswana",
      "dial_code": "267",
      "short_code": "BW"
    },
    {
      "country": "Brazil",
      "dial_code": "55",
      "short_code": "BR"
    },
    {
      "country": "British Indian Ocean Territory",
      "dial_code": "246",
      "short_code": "IO"
    },
    {
      "country": "Brunei Darussalam",
      "dial_code": "673",
      "short_code": "BN"
    },
    {
      "country": "Bulgaria",
      "dial_code": "359",
      "short_code": "BG"
    },
    {
      "country": "Burkina Faso",
      "dial_code": "226",
      "short_code": "BF"
    },
    {
      "country": "Burundi",
      "dial_code": "257",
      "short_code": "BI"
    },
    {
      "country": "Cambodia",
      "dial_code": "855",
      "short_code": "KH"
    },
    {
      "country": "Cameroon",
      "dial_code": "237",
      "short_code": "CM"
    },
    {
      "country": "Canada",
      "dial_code": "1",
      "short_code": "CA"
    },
    {
      "country": "Cape Verde",
      "dial_code": "238",
      "short_code": "CV"
    },
    {
      "country": "Cayman Islands",
      "dial_code": " 345",
      "short_code": "KY"
    },
    {
      "country": "Central African Republic",
      "dial_code": "236",
      "short_code": "CF"
    },
    {
      "country": "Chad",
      "dial_code": "235",
      "short_code": "TD"
    },
    {
      "country": "Chile",
      "dial_code": "56",
      "short_code": "CL"
    },
    {
      "country": "China",
      "dial_code": "86",
      "short_code": "CN"
    },
    {
      "country": "Christmas Island",
      "dial_code": "61",
      "short_code": "CX"
    },
    {
      "country": "Cocos (Keeling) Islands",
      "dial_code": "61",
      "short_code": "CC"
    },
    {
      "country": "Colombia",
      "dial_code": "57",
      "short_code": "CO"
    },
    {
      "country": "Comoros",
      "dial_code": "269",
      "short_code": "KM"
    },
    {
      "country": "Congo",
      "dial_code": "242",
      "short_code": "CG"
    },
    {
      "country": "The Democratic Republic of the Congo",
      "dial_code": "243",
      "short_code": "CD"
    },
    {
      "country": "Cook Islands",
      "dial_code": "682",
      "short_code": "CK"
    },
    {
      "country": "Costa Rica",
      "dial_code": "506",
      "short_code": "CR"
    },
    {
      "country": "Cote d'Ivoire",
      "dial_code": "225",
      "short_code": "CI"
    },
    {
      "country": "Croatia",
      "dial_code": "385",
      "short_code": "HR"
    },
    {
      "country": "Cuba",
      "dial_code": "53",
      "short_code": "CU"
    },
    {
      "country": "Cyprus",
      "dial_code": "357",
      "short_code": "CY"
    },
    {
      "country": "Czech Republic",
      "dial_code": "420",
      "short_code": "CZ"
    },
    {
      "country": "Denmark",
      "dial_code": "45",
      "short_code": "DK"
    },
    {
      "country": "Djibouti",
      "dial_code": "253",
      "short_code": "DJ"
    },
    {
      "country": "Dominica",
      "dial_code": "1767",
      "short_code": "DM"
    },
    {
      "country": "Dominican Republic",
      "dial_code": "1849",
      "short_code": "DO"
    },
    {
      "country": "Ecuador",
      "dial_code": "593",
      "short_code": "EC"
    },
    {
      "country": "Egypt",
      "dial_code": "20",
      "short_code": "EG"
    },
    {
      "country": "El Salvador",
      "dial_code": "503",
      "short_code": "SV"
    },
    {
      "country": "Equatorial Guinea",
      "dial_code": "240",
      "short_code": "GQ"
    },
    {
      "country": "Eritrea",
      "dial_code": "291",
      "short_code": "ER"
    },
    {
      "country": "Estonia",
      "dial_code": "372",
      "short_code": "EE"
    },
    {
      "country": "Ethiopia",
      "dial_code": "251",
      "short_code": "ET"
    },
    {
      "country": "Falkland Islands (Malvinas)",
      "dial_code": "500",
      "short_code": "FK"
    },
    {
      "country": "Faroe Islands",
      "dial_code": "298",
      "short_code": "FO"
    },
    {
      "country": "Fiji",
      "dial_code": "679",
      "short_code": "FJ"
    },
    {
      "country": "Finland",
      "dial_code": "358",
      "short_code": "FI"
    },
    {
      "country": "France",
      "dial_code": "33",
      "short_code": "FR"
    },
    {
      "country": "French Guiana",
      "dial_code": "594",
      "short_code": "GF"
    },
    {
      "country": "French Polynesia",
      "dial_code": "689",
      "short_code": "PF"
    },
    {
      "country": "Gabon",
      "dial_code": "241",
      "short_code": "GA"
    },
    {
      "country": "Gambia",
      "dial_code": "220",
      "short_code": "GM"
    },
    {
      "country": "Georgia",
      "dial_code": "995",
      "short_code": "GE"
    },
    {
      "country": "Germany",
      "dial_code": "49",
      "short_code": "DE"
    },
    {
      "country": "Ghana",
      "dial_code": "233",
      "short_code": "GH"
    },
    {
      "country": "Gibraltar",
      "dial_code": "350",
      "short_code": "GI"
    },
    {
      "country": "Greece",
      "dial_code": "30",
      "short_code": "GR"
    },
    {
      "country": "Greenland",
      "dial_code": "299",
      "short_code": "GL"
    },
    {
      "country": "Grenada",
      "dial_code": "1473",
      "short_code": "GD"
    },
    {
      "country": "Guadeloupe",
      "dial_code": "590",
      "short_code": "GP"
    },
    {
      "country": "Guam",
      "dial_code": "1671",
      "short_code": "GU"
    },
    {
      "country": "Guatemala",
      "dial_code": "502",
      "short_code": "GT"
    },
    {
      "country": "Guernsey",
      "dial_code": "44",
      "short_code": "GG"
    },
    {
      "country": "Guinea",
      "dial_code": "224",
      "short_code": "GN"
    },
    {
      "country": "Guinea-Bissau",
      "dial_code": "245",
      "short_code": "GW"
    },
    {
      "country": "Guyana",
      "dial_code": "595",
      "short_code": "GY"
    },
    {
      "country": "Haiti",
      "dial_code": "509",
      "short_code": "HT"
    },
    {
      "country": "Holy See (Vatican City State)",
      "dial_code": "379",
      "short_code": "VA"
    },
    {
      "country": "Honduras",
      "dial_code": "504",
      "short_code": "HN"
    },
    {
      "country": "Hong Kong",
      "dial_code": "852",
      "short_code": "HK"
    },
    {
      "country": "Hungary",
      "dial_code": "36",
      "short_code": "HU"
    },
    {
      "country": "Iceland",
      "dial_code": "354",
      "short_code": "IS"
    },
    {
      "country": "India",
      "dial_code": "91",
      "short_code": "IN"
    },
    {
      "country": "Indonesia",
      "dial_code": "62",
      "short_code": "ID"
    },
    {
      "country": "Iran, Islamic Republic of Persian Gulf",
      "dial_code": "98",
      "short_code": "IR"
    },
    {
      "country": "Iraq",
      "dial_code": "964",
      "short_code": "IQ"
    },
    {
      "country": "Ireland",
      "dial_code": "353",
      "short_code": "IE"
    },
    {
      "country": "Isle of Man",
      "dial_code": "44",
      "short_code": "IM"
    },
    {
      "country": "Israel",
      "dial_code": "972",
      "short_code": "IL"
    },
    {
      "country": "Italy",
      "dial_code": "39",
      "short_code": "IT"
    },
    {
      "country": "Jamaica",
      "dial_code": "1876",
      "short_code": "JM"
    },
    {
      "country": "Japan",
      "dial_code": "81",
      "short_code": "JP"
    },
    {
      "country": "Jersey",
      "dial_code": "44",
      "short_code": "JE"
    },
    {
      "country": "Jordan",
      "dial_code": "962",
      "short_code": "JO"
    },
    {
      "country": "Kazakhstan",
      "dial_code": "77",
      "short_code": "KZ"
    },
    {
      "country": "Kenya",
      "dial_code": "254",
      "short_code": "KE"
    },
    {
      "country": "Kiribati",
      "dial_code": "686",
      "short_code": "KI"
    },
    {
      "country": "Democratic People's Republic of Korea",
      "dial_code": "850",
      "short_code": "KP"
    },
    {
      "country": "Republic of South Korea",
      "dial_code": "82",
      "short_code": "KR"
    },
    {
      "country": "Kuwait",
      "dial_code": "965",
      "short_code": "KW"
    },
    {
      "country": "Kyrgyzstan",
      "dial_code": "996",
      "short_code": "KG"
    },
    {
      "country": "Laos",
      "dial_code": "856",
      "short_code": "LA"
    },
    {
      "country": "Latvia",
      "dial_code": "371",
      "short_code": "LV"
    },
    {
      "country": "Lebanon",
      "dial_code": "961",
      "short_code": "LB"
    },
    {
      "country": "Lesotho",
      "dial_code": "266",
      "short_code": "LS"
    },
    {
      "country": "Liberia",
      "dial_code": "231",
      "short_code": "LR"
    },
    {
      "country": "Libyan Arab Jamahiriya",
      "dial_code": "218",
      "short_code": "LY"
    },
    {
      "country": "Liechtenstein",
      "dial_code": "423",
      "short_code": "LI"
    },
    {
      "country": "Lithuania",
      "dial_code": "370",
      "short_code": "LT"
    },
    {
      "country": "Luxembourg",
      "dial_code": "352",
      "short_code": "LU"
    },
    {
      "country": "Macao",
      "dial_code": "853",
      "short_code": "MO"
    },
    {
      "country": "Macedonia",
      "dial_code": "389",
      "short_code": "MK"
    },
    {
      "country": "Madagascar",
      "dial_code": "261",
      "short_code": "MG"
    },
    {
      "country": "Malawi",
      "dial_code": "265",
      "short_code": "MW"
    },
    {
      "country": "Malaysia",
      "dial_code": "60",
      "short_code": "MY"
    },
    {
      "country": "Maldives",
      "dial_code": "960",
      "short_code": "MV"
    },
    {
      "country": "Mali",
      "dial_code": "223",
      "short_code": "ML"
    },
    {
      "country": "Malta",
      "dial_code": "356",
      "short_code": "MT"
    },
    {
      "country": "Marshall Islands",
      "dial_code": "692",
      "short_code": "MH"
    },
    {
      "country": "Martinique",
      "dial_code": "596",
      "short_code": "MQ"
    },
    {
      "country": "Mauritania",
      "dial_code": "222",
      "short_code": "MR"
    },
    {
      "country": "Mauritius",
      "dial_code": "230",
      "short_code": "MU"
    },
    {
      "country": "Mayotte",
      "dial_code": "262",
      "short_code": "YT"
    },
    {
      "country": "Mexico",
      "dial_code": "52",
      "short_code": "MX"
    },
    {
      "country": "Federated States of Micronesia",
      "dial_code": "691",
      "short_code": "FM"
    },
    {
      "country": "Moldova",
      "dial_code": "373",
      "short_code": "MD"
    },
    {
      "country": "Monaco",
      "dial_code": "377",
      "short_code": "MC"
    },
    {
      "country": "Mongolia",
      "dial_code": "976",
      "short_code": "MN"
    },
    {
      "country": "Montenegro",
      "dial_code": "382",
      "short_code": "ME"
    },
    {
      "country": "Montserrat",
      "dial_code": "1664",
      "short_code": "MS"
    },
    {
      "country": "Morocco",
      "dial_code": "212",
      "short_code": "MA"
    },
    {
      "country": "Mozambique",
      "dial_code": "258",
      "short_code": "MZ"
    },
    {
      "country": "Myanmar",
      "dial_code": "95",
      "short_code": "MM"
    },
    {
      "country": "Namibia",
      "dial_code": "264",
      "short_code": "NA"
    },
    {
      "country": "Nauru",
      "dial_code": "674",
      "short_code": "NR"
    },
    {
      "country": "Nepal",
      "dial_code": "977",
      "short_code": "NP"
    },
    {
      "country": "Netherlands",
      "dial_code": "31",
      "short_code": "NL"
    },
    {
      "country": "Netherlands Antilles",
      "dial_code": "599",
      "short_code": "AN"
    },
    {
      "country": "New Caledonia",
      "dial_code": "687",
      "short_code": "NC"
    },
    {
      "country": "New Zealand",
      "dial_code": "64",
      "short_code": "NZ"
    },
    {
      "country": "Nicaragua",
      "dial_code": "505",
      "short_code": "NI"
    },
    {
      "country": "Niger",
      "dial_code": "227",
      "short_code": "NE"
    },
    {
      "country": "Niue",
      "dial_code": "683",
      "short_code": "NU"
    },
    {
      "country": "Norfolk Island",
      "dial_code": "672",
      "short_code": "NF"
    },
    {
      "country": "Northern Mariana Islands",
      "dial_code": "1670",
      "short_code": "MP"
    },
    {
      "country": "Norway",
      "dial_code": "47",
      "short_code": "NO"
    },
    {
      "country": "Oman",
      "dial_code": "968",
      "short_code": "OM"
    },
    {
      "country": "Pakistan",
      "dial_code": "92",
      "short_code": "PK"
    },
    {
      "country": "Palau",
      "dial_code": "680",
      "short_code": "PW"
    },
    {
      "country": "Palestinian Territory",
      "dial_code": "970",
      "short_code": "PS"
    },
    {
      "country": "Panama",
      "dial_code": "507",
      "short_code": "PA"
    },
    {
      "country": "Papua New Guinea",
      "dial_code": "675",
      "short_code": "PG"
    },
    {
      "country": "Paraguay",
      "dial_code": "595",
      "short_code": "PY"
    },
    {
      "country": "Peru",
      "dial_code": "51",
      "short_code": "PE"
    },
    {
      "country": "Philippines",
      "dial_code": "63",
      "short_code": "PH"
    },
    {
      "country": "Pitcairn",
      "dial_code": "872",
      "short_code": "PN"
    },
    {
      "country": "Poland",
      "dial_code": "48",
      "short_code": "PL"
    },
    {
      "country": "Portugal",
      "dial_code": "351",
      "short_code": "PT"
    },
    {
      "country": "Puerto Rico",
      "dial_code": "1939",
      "short_code": "PR"
    },
    {
      "country": "Qatar",
      "dial_code": "974",
      "short_code": "QA"
    },
    {
      "country": "Romania",
      "dial_code": "40",
      "short_code": "RO"
    },
    {
      "country": "Russia",
      "dial_code": "7",
      "short_code": "RU"
    },
    {
      "country": "Rwanda",
      "dial_code": "250",
      "short_code": "RW"
    },
    {
      "country": "Reunion",
      "dial_code": "262",
      "short_code": "RE"
    },
    {
      "country": "Saint Barthelemy",
      "dial_code": "590",
      "short_code": "BL"
    },
    {
      "country": "Saint Helena",
      "dial_code": "290",
      "short_code": "SH"
    },
    {
      "country": "Saint Kitts and Nevis",
      "dial_code": "1869",
      "short_code": "KN"
    },
    {
      "country": "Saint Lucia",
      "dial_code": "1758",
      "short_code": "LC"
    },
    {
      "country": "Saint Martin",
      "dial_code": "590",
      "short_code": "MF"
    },
    {
      "country": "Saint Pierre and Miquelon",
      "dial_code": "508",
      "short_code": "PM"
    },
    {
      "country": "Saint Vincent and the Grenadines",
      "dial_code": "1784",
      "short_code": "VC"
    },
    {
      "country": "Samoa",
      "dial_code": "685",
      "short_code": "WS"
    },
    {
      "country": "San Marino",
      "dial_code": "378",
      "short_code": "SM"
    },
    {
      "country": "Sao Tome and Principe",
      "dial_code": "239",
      "short_code": "ST"
    },
    {
      "country": "Saudi Arabia",
      "dial_code": "966",
      "short_code": "SA"
    },
    {
      "country": "Senegal",
      "dial_code": "221",
      "short_code": "SN"
    },
    {
      "country": "Serbia",
      "dial_code": "381",
      "short_code": "RS"
    },
    {
      "country": "Seychelles",
      "dial_code": "248",
      "short_code": "SC"
    },
    {
      "country": "Sierra Leone",
      "dial_code": "232",
      "short_code": "SL"
    },
    {
      "country": "Singapore",
      "dial_code": "65",
      "short_code": "SG"
    },
    {
      "country": "Slovakia",
      "dial_code": "421",
      "short_code": "SK"
    },
    {
      "country": "Slovenia",
      "dial_code": "386",
      "short_code": "SI"
    },
    {
      "country": "Solomon Islands",
      "dial_code": "677",
      "short_code": "SB"
    },
    {
      "country": "Somalia",
      "dial_code": "252",
      "short_code": "SO"
    },
    {
      "country": "South Africa",
      "dial_code": "27",
      "short_code": "ZA"
    },
    {
      "country": "South Sudan",
      "dial_code": "211",
      "short_code": "SS"
    },
    {
      "country": "South Georgia and the South Sandwich Islands",
      "dial_code": "500",
      "short_code": "GS"
    },
    {
      "country": "Spain",
      "dial_code": "34",
      "short_code": "ES"
    },
    {
      "country": "Sri Lanka",
      "dial_code": "94",
      "short_code": "LK"
    },
    {
      "country": "Sudan",
      "dial_code": "249",
      "short_code": "SD"
    },
    {
      "country": "Suricountry",
      "dial_code": "597",
      "short_code": "SR"
    },
    {
      "country": "Svalbard and Jan Mayen",
      "dial_code": "47",
      "short_code": "SJ"
    },
    {
      "country": "Swaziland",
      "dial_code": "268",
      "short_code": "SZ"
    },
    {
      "country": "Sweden",
      "dial_code": "46",
      "short_code": "SE"
    },
    {
      "country": "Switzerland",
      "dial_code": "41",
      "short_code": "CH"
    },
    {
      "country": "Syrian Arab Republic",
      "dial_code": "963",
      "short_code": "SY"
    },
    {
      "country": "Taiwan",
      "dial_code": "886",
      "short_code": "TW"
    },
    {
      "country": "Tajikistan",
      "dial_code": "992",
      "short_code": "TJ"
    },
    {
      "country": "Tanzania",
      "dial_code": "255",
      "short_code": "TZ"
    },
    {
      "country": "Thailand",
      "dial_code": "66",
      "short_code": "TH"
    },
    {
      "country": "Timor-Leste",
      "dial_code": "670",
      "short_code": "TL"
    },
    {
      "country": "Togo",
      "dial_code": "228",
      "short_code": "TG"
    },
    {
      "country": "Tokelau",
      "dial_code": "690",
      "short_code": "TK"
    },
    {
      "country": "Tonga",
      "dial_code": "676",
      "short_code": "TO"
    },
    {
      "country": "Trinidad and Tobago",
      "dial_code": "1868",
      "short_code": "TT"
    },
    {
      "country": "Tunisia",
      "dial_code": "216",
      "short_code": "TN"
    },
    {
      "country": "Turkey",
      "dial_code": "90",
      "short_code": "TR"
    },
    {
      "country": "Turkmenistan",
      "dial_code": "993",
      "short_code": "TM"
    },
    {
      "country": "Turks and Caicos Islands",
      "dial_code": "1649",
      "short_code": "TC"
    },
    {
      "country": "Tuvalu",
      "dial_code": "688",
      "short_code": "TV"
    },
    {
      "country": "Uganda",
      "dial_code": "256",
      "short_code": "UG"
    },
    {
      "country": "Ukraine",
      "dial_code": "380",
      "short_code": "UA"
    },
    {
      "country": "United Arab Emirates",
      "dial_code": "971",
      "short_code": "AE"
    },
    {
      "country": "United Kingdom",
      "dial_code": "44",
      "short_code": "GB"
    },
    {
      "country": "United States",
      "dial_code": "1",
      "short_code": "US"
    },
    {
      "country": "Uruguay",
      "dial_code": "598",
      "short_code": "UY"
    },
    {
      "country": "Uzbekistan",
      "dial_code": "998",
      "short_code": "UZ"
    },
    {
      "country": "Vanuatu",
      "dial_code": "678",
      "short_code": "VU"
    },
    {
      "country": "Venezuela",
      "dial_code": "58",
      "short_code": "VE"
    },
    {
      "country": "Vietnam",
      "dial_code": "84",
      "short_code": "VN"
    },
    {
      "country": "British Virgin Islands",
      "dial_code": "1284",
      "short_code": "VG"
    },
    {
      "country": "U.S. Virgin Islands",
      "dial_code": "1340",
      "short_code": "VI"
    },
    {
      "country": "Wallis and Futuna",
      "dial_code": "681",
      "short_code": "WF"
    },
    {
      "country": "Yemen",
      "dial_code": "967",
      "short_code": "YE"
    },
    {
      "country": "Zambia",
      "dial_code": "260",
      "short_code": "ZM"
    },
    {
      "country": "Zimbabwe",
      "dial_code": "263",
      "short_code": "ZW"
    }
  ]
}""";

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<CountryCode>? data;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<CountryCode>.from(
                json["data"].map((x) => CountryCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CountryCode {
  CountryCode({
    this.country,
    this.dialCode,
    this.shortCode,
  });

  String? country;
  String? dialCode;
  String? shortCode;

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        country: json["country"],
        dialCode: json["dial_code"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "dial_code": dialCode,
        "short_code": shortCode,
      };
}
