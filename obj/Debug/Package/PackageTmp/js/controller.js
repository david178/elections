
//mock data
var app = angular.module('main', ['ngAnimate']).
controller('mainController', function ($scope) {




    //***************************************************************
    //Grab localStorage data
    var turnoutData, congressData, governorData, controllerData, assemblyData,
        senateData, countyData, administratorData, constableData, judgeData,
        regentData, boardData, trusteeData, sheriffData, peaceData,
        supremeData, secretaryData, treasurerData, attorneyData,
        questionData;
    

    //sessionStorage
    turnoutData = sessionStorage.getItem("_turnoutBox");
    congressData = sessionStorage.getItem("_congressBox");
    governorData = sessionStorage.getItem("_governorBox");
    secretaryData = sessionStorage.getItem("_secretaryBox"); //added
    treasurerData = sessionStorage.getItem("_treasurerBox"); //added
    controllerData = sessionStorage.getItem("_controllerBox");
    attorneyData = sessionStorage.getItem("_attorneyBox"); //added
    assemblyData = sessionStorage.getItem("_assemblyBox");
    senateData = sessionStorage.getItem("_senateBox");
    countyData = sessionStorage.getItem("_countyBox");
    administratorData = sessionStorage.getItem("_administratorBox");
    supremeData = sessionStorage.getItem("_supremeBox"); //added
    constableData = sessionStorage.getItem("_constableBox");
    judgeData = sessionStorage.getItem("_judgeBox");
    regentData = sessionStorage.getItem("_regentBox");
    boardData = sessionStorage.getItem("_boardBox");
    trusteeData = sessionStorage.getItem("_trusteeBox");
    sheriffData = sessionStorage.getItem("_sheriffBox");
    peaceData = sessionStorage.getItem("_peaceBox");
    questionData = sessionStorage.getItem("_questionBox");

    //localStorage
//    turnoutData = localStorage.getItem("_turnoutBox");
//    congressData = localStorage.getItem("_congressBox");
//    governorData = localStorage.getItem("_governorBox");
//    secretaryData = localStorage.getItem("_secretaryBox"); //added
//    treasurerData = localStorage.getItem("_treasurerBox"); //added
//    controllerData = localStorage.getItem("_controllerBox");
//    attorneyData = localStorage.getItem("_attorneyBox"); //added
//    assemblyData = localStorage.getItem("_assemblyBox");
//    senateData = localStorage.getItem("_senateBox");
//    countyData = localStorage.getItem("_countyBox");
//    administratorData = localStorage.getItem("_administratorBox");
//    supremeData = localStorage.getItem("_supremeBox"); //added
//    constableData = localStorage.getItem("_constableBox");
//    judgeData = localStorage.getItem("_judgeBox");
//    regentData = localStorage.getItem("_regentBox");
//    boardData = localStorage.getItem("_boardBox");
//    trusteeData = localStorage.getItem("_trusteeBox");
//    sheriffData = localStorage.getItem("_sheriffBox");
//    peaceData = localStorage.getItem("_peaceBox");
//    questionData = localStorage.getItem("_questionBox");

    //***************************************************************






    //***************************************************************
    //Setting expirations for localStorage w/ timeStamp
    

//    store timestamp in the object you store in the localStorage

//var object = {value: "value", timestamp: new Date().getTime()}
//localStorage.setItem("key", JSON.stringify(object));
//Yparse the object, get the timestamp and compare with the current Date, and if necessary, update the value of the object.

//var object = JSON.parse(localStorage.getItem("key")),
//    dateString = object.timestamp,
//    now = new Date().getTime().toString();

//compareTime(dateString, now); //to implement


    //OR use lib 
    //https://code.google.com/p/local-cache/

    //***************************************************************









    //***************************************************************
    //Check for cases: null (no localStorage setting) | true | false

    //default case (no storage val found)
    if (turnoutData === null) {
        $scope.turnout = true; //featured
    }
    if (turnoutData === 'true') {
        $scope.turnout = true;
    }
    if (turnoutData === 'false') {
        $scope.turnout = false;
    }

    //default case (no storage val found)
    if (congressData === null) {
        $scope.congress = true; //featured
    }
    if (congressData === 'true') {
        $scope.congress = true;
    }
    if (congressData === 'false') {
        $scope.congress = false;
    }

    //default case (no storage val found)
    if (governorData === null) {
        $scope.governor = true; //featured
    }
    if (governorData === 'true') {
        $scope.governor = true;
    }
    if (governorData === 'false') {
        $scope.governor = false;
    }

    //default case (no storage val found)
    if (secretaryData === null) {
        $scope.secretary = true;  //featured
    }
    if (secretaryData === 'true') {
        $scope.secretary = true;
    }
    if (secretaryData === 'false') {
        $scope.secretary = false;
    }

    //default case (no storage val found)
    if (treasurerData === null) {
        $scope.treasurer = false;
    }
    if (treasurerData === 'true') {
        $scope.treasurer = true;
    }
    if (treasurerData === 'false') {
        $scope.treasurer = false;
    }

    //default case (no storage val found)
    if (controllerData === null) {
        $scope.controller = false;
    }
    if (controllerData === 'true') {
        $scope.controller = true;
    }
    if (controllerData === 'false') {
        $scope.controller = false;
    }

    //default case (no storage val found)
    if (attorneyData === null) {
        $scope.attorney = false;
    }
    if (attorneyData === 'true') {
        $scope.attorney = true;
    }
    if (attorneyData === 'false') {
        $scope.attorney = false;
    }

    //default case (no storage val found)
    if (assemblyData === null) {
        $scope.assembly = false;
    }
    if (assemblyData === 'true') {
        $scope.assembly = true;
    }
    if (assemblyData === 'false') {
        $scope.assembly = false;
    }

    //default case (no storage val found)
    if (senateData === null) {
        $scope.senate = true; //featured
    }
    if (senateData === 'true') {
        $scope.senate = true;
    }
    if (senateData === 'false') {
        $scope.senate = false;
    }

    //default case (no storage val found)
    if (countyData === null) {
        $scope.county = true; //featured
    }
    if (countyData === 'true') {
        $scope.county = true;
    }
    if (countyData === 'false') {
        $scope.county = false;
    }

    //default case (no storage val found)
    if (administratorData === null) {
        $scope.administrator = false;
    }
    if (administratorData === 'true') {
        $scope.administrator = true;
    }
    if (administratorData === 'false') {
        $scope.administrator = false;
    }

    //default case (no storage val found)
    if (supremeData === null) {
        $scope.supreme = false;
    }
    if (supremeData === 'true') {
        $scope.supreme = true;
    }
    if (supremeData === 'false') {
        $scope.supreme = false;
    }

    //default case (no storage val found)
    if (constableData === null) {
        $scope.constable = false;
    }
    if (constableData === 'true') {
        $scope.constable = true;
    }
    if (constableData === 'false') {
        $scope.constable = false;
    }

    //default case (no storage val found)
    if (judgeData === null) {
        $scope.judge = false;
    }
    if (judgeData === 'true') {
        $scope.judge = true;
    }
    if (judgeData === 'false') {
        $scope.judge = false;
    }

    //default case (no storage val found)
    if (regentData === null) {
        $scope.regent = false;
    }
    if (regentData === 'true') {
        $scope.regent = true;
    }
    if (regentData === 'false') {
        $scope.regent = false;
    }


    //default case (no storage val found)
    if (boardData === null) {
        $scope.board = false;
    }
    if (boardData === 'true') {
        $scope.board = true;
    }
    if (boardData === 'false') {
        $scope.board = false;
    }

    //default case (no storage val found)
    if (trusteeData === null) {
        $scope.trustee = false;
    }
    if (trusteeData === 'true') {
        $scope.trustee = true;
    }
    if (trusteeData === 'false') {
        $scope.trustee = false;
    }

    //default case (no storage val found)
    if (sheriffData === null) {
        $scope.sheriff = false;
    }
    if (sheriffData === 'true') {
        $scope.sheriff = true;
    }
    if (sheriffData === 'false') {
        $scope.sheriff = false;
    }

    //default case (no storage val found)
    if (peaceData === null) {
        $scope.peace = false;
    }
    if (peaceData === 'true') {
        $scope.peace = true;
    }
    if (peaceData === 'false') {
        $scope.peace = false;
    }

    //default case (no storage val found)
    if (questionData === null) {
        $scope.question = true;
    }
    if (questionData === 'true') {
        $scope.question = true;
    }
    if (questionData === 'false') {
        $scope.question = false;
    }
    //***************************************************************








    //***************************************************************
    //    //Muni Elections Switch (Uncomment to switch to Muni Election, this will remove filtering as well)
    //    $scope.all = true; //default
    //    //All stats & featured races
    //    $scope.turnout = true; //default
    //    $scope.congress = false; //featured
    //    $scope.governor = false; //featured
    //    $scope.controller = false;
    //    $scope.senate = false; //featured
    //    $scope.assembly = false;
    //    $scope.county = false; //featured
    //    $scope.administrator = false;
    //    $scope.constable = false;
    //    $scope.judge = false;
    //    $scope.regent = false;
    //    $scope.sheriff = false;
    //    $scope.peace = false;

    //    //hide the filtering feature
    //    document.getElementById("quickDirect").style.display = "none";

    //    //hide the refine feature
    //    document.getElementById("refineButton").style.display = "none";

    //    //hide the colorGuide feature
    //    document.getElementById("colorGuide").style.display = "none";

    //***************************************************************







    //***************************************************************
    //'x' hide tags

    $scope.hideTags = function (tag) {

        if (tag === 'turnout') {
            $scope.turnout = false;
            //store in localStorage
            $scope.storageChange(false, 'turnout');
        }
        if (tag === 'congress') {
            $scope.congress = false;
            //store in localStorage
            $scope.storageChange(false, 'congress');
        }
        if (tag === 'governor') {
            $scope.governor = false;
            //store in localStorage
            $scope.storageChange(false, 'governor');
        }
        if (tag === 'secretary') {
            $scope.secretary = false;
            //store in localStorage
            $scope.storageChange(false, 'secretary');
        }
        if (tag === 'treasurer') {
            $scope.treasurer = false;
            //store in localStorage
            $scope.storageChange(false, 'treasurer');
        }
        if (tag === 'controller') {
            $scope.controller = false;
            //store in localStorage
            $scope.storageChange(false, 'controller');
        }
        if (tag === 'attorney') {
            $scope.attorney = false;
            //store in localStorage
            $scope.storageChange(false, 'attorney');
        }
        if (tag === 'senate') {
            $scope.senate = false;
            //store in localStorage
            $scope.storageChange(false, 'senate');
        }
        if (tag === 'assembly') {
            $scope.assembly = false;
            //store in localStorage
            $scope.storageChange(false, 'assembly');
        }
        if (tag === 'county') {
            $scope.county = false;
            //store in localStorage
            $scope.storageChange(false, 'county');
        }
        if (tag === 'administrator') {
            $scope.administrator = false;
            //store in localStorage
            $scope.storageChange(false, 'administrator');
        }
        if (tag === 'supreme') {
            $scope.supreme = false;
            //store in localStorage
            $scope.storageChange(false, 'supreme');
        }
        if (tag === 'constable') {
            $scope.constable = false;
            //store in localStorage
            $scope.storageChange(false, 'constable');
        }
        if (tag === 'judge') {
            $scope.judge = false;
            //store in localStorage
            $scope.storageChange(false, 'judge');
        }
        if (tag === 'regent') {
            $scope.regent = false;
            //store in localStorage
            $scope.storageChange(false, 'regent');
        }
        if (tag === 'board') {
            $scope.board = false;
            //store in localStorage
            $scope.storageChange(false, 'board');
        }
        if (tag === 'trustee') {
            $scope.trustee = false;
            //store in localStorage
            $scope.storageChange(false, 'trustee');
        }
        if (tag === 'sheriff') {
            $scope.sheriff = false;
            //store in localStorage
            $scope.storageChange(false, 'sheriff');
        }
        if (tag === 'peace') {
            $scope.peace = false;
            //store in localStorage
            $scope.storageChange(false, 'peace');
        }
        if (tag === 'question') {
            $scope.question = false;
            //store in localStorage
            $scope.storageChange(false, 'question');
        }

    };
    //***************************************************************






    //***************************************************************
    //Constructing the localStorage.setItem string 
    //(gets called from ng-change

    var storageSetter;

    //listen for checkbox check events to update localStorage
    $scope.storageChange = function (scopeVal, storageString) {

        //construct the storageSetter
        storageSetter = "_" + storageString + "Box";

        //set the localStorage based upon model state
        if (scopeVal === true) {

            $scope.storageString = scopeVal;

            sessionStorage.setItem(storageSetter, 'true'); //sessionStorage
//            localStorage.setItem(storageSetter, 'true'); //localStorage

        } else {

            $scope.storageString = scopeVal;

            sessionStorage.setItem(storageSetter, 'false'); //sessionStorage
//            localStorage.setItem(storageSetter, 'false'); //localStorage

        }

        console.log(storageSetter);


        //call for consistency
        $scope.consistency();

        //call for alert box check  
        $scope.alertBox();

    };
    //***************************************************************






    //***************************************************************
    //refine popUp calls

    //show refinePopUp
    $scope.showPopUp = function () {
        document.getElementById("modalShade").style.display = "block";

        //remove body scrollbar
        document.documentElement.style.overflow = 'hidden';  // firefox, chrome
        document.body.scroll = "no"; // ie only


        //mobile compat
        if (navigator.userAgent.search("Safari") >= 0 && navigator.userAgent.search("Chrome") < 0) {
            //  $("#theBody").removeClass("noscroll");
            $('body').addClass("noscroll");

            console.log('hit for safari - 1');
        }

    };

    //apply refine settings
    $scope.applySettings = function () {
        document.getElementById("modalShade").style.display = "none";

        //restore body scrollbar
        document.documentElement.style.overflow = 'auto';  // firefox, chrome
        document.body.scroll = "yes"; // ie only


        //mobile compat
        if (navigator.userAgent.search("Safari") >= 0 && navigator.userAgent.search("Chrome") < 0) {
            //  $("#theBody").removeClass("noscroll");
            $('body').removeClass("noscroll");

            console.log('hit for safari - 2');
        }

    };
    //***************************************************************



    //***************************************************************
    //Show All Results
    $scope.showAllResults = function () {

            //All stats & featured races
            $scope.turnout = true; //featured
            $scope.congress = true; //featured
            $scope.governor = true; //featured
            $scope.secretary = true;  //featured
            $scope.treasurer = true;
            $scope.controller = true;
            $scope.attorney = true;
            $scope.senate = true; //featured
            $scope.assembly = true;
            $scope.county = true; //featured
            $scope.administrator = true;
            $scope.supreme = true;
            $scope.constable = true;
            $scope.judge = true;
            $scope.regent = true;
            $scope.board = true;
            $scope.trustee = true;
            $scope.sheriff = true;
            $scope.peace = true;
            $scope.question = true;  //featured



            //store values in localStorage
            $scope.storageChange(true, 'turnout');
            $scope.storageChange(true, 'congress');
            $scope.storageChange(true, 'governor');
            $scope.storageChange(true, 'secretary');
            $scope.storageChange(true, 'treasurer');
            $scope.storageChange(true, 'controller');
            $scope.storageChange(true, 'attorney');
            $scope.storageChange(true, 'senate');
            $scope.storageChange(true, 'assembly');
            $scope.storageChange(true, 'county');
            $scope.storageChange(true, 'administrator');
            $scope.storageChange(true, 'supreme');
            $scope.storageChange(true, 'constable');
            $scope.storageChange(true, 'judge');
            $scope.storageChange(true, 'regent');
            $scope.storageChange(true, 'board');
            $scope.storageChange(true, 'trustee');
            $scope.storageChange(true, 'sheriff');
            $scope.storageChange(true, 'peace');
            $scope.storageChange(true, 'question');

            //call for alert box check  
            $scope.alertBox();
    };
    //***************************************************************


    //***************************************************************
    //Show No Results
    $scope.showNoResults = function () {

            //No stats & featured races
            $scope.turnout = false; //featured
            $scope.congress = false; //featured
            $scope.governor = false; //featured
            $scope.secretary = false;  //featured
            $scope.treasurer = false;
            $scope.controller = false;
            $scope.attorney = false;
            $scope.senate = false; //featured
            $scope.assembly = false;
            $scope.county = false; //featured
            $scope.administrator = false;
            $scope.supreme = false;
            $scope.constable = false;
            $scope.judge = false;
            $scope.regent = false;
            $scope.board = false;
            $scope.trustee = false;
            $scope.sheriff = false;
            $scope.peace = false;
            $scope.question = false;  //featured



            //store values in localStorage
            $scope.storageChange(false, 'turnout');
            $scope.storageChange(false, 'congress');
            $scope.storageChange(false, 'governor');
            $scope.storageChange(false, 'secretary');
            $scope.storageChange(false, 'treasurer');
            $scope.storageChange(false, 'controller');
            $scope.storageChange(false, 'attorney');
            $scope.storageChange(false, 'senate');
            $scope.storageChange(false, 'assembly');
            $scope.storageChange(false, 'county');
            $scope.storageChange(false, 'administrator');
            $scope.storageChange(false, 'supreme');
            $scope.storageChange(false, 'constable');
            $scope.storageChange(false, 'judge');
            $scope.storageChange(false, 'regent');
            $scope.storageChange(false, 'board');
            $scope.storageChange(false, 'trustee');
            $scope.storageChange(false, 'sheriff');
            $scope.storageChange(false, 'peace');
            $scope.storageChange(false, 'question');


            //call for alert box check  
            $scope.alertBox();
    };
    //***************************************************************




    //***************************************************************
    //Reset to default settings (isolated / localStorage)
    $scope.defaultSettings = function () {

        //checkbox defaults (default featured races)
        $scope.turnout = true; //featured
        $scope.congress = true; //featured
        $scope.governor = true; //featured
        $scope.secretary = true; //featured
        $scope.treasurer = false;
        $scope.controller = false;
        $scope.attorney = false;
        $scope.senate = true; //featured
        $scope.assembly = false;
        $scope.county = true; //featured
        $scope.administrator = false;
        $scope.supreme = false;
        $scope.constable = false;
        $scope.judge = false;
        $scope.regent = false;
        $scope.board = false;
        $scope.trustee = false;
        $scope.sheriff = false;
        $scope.peace = false;
        $scope.question = true; //featured




        //store values in localStorage
        $scope.storageChange(true, 'turnout'); //featured
        $scope.storageChange(true, 'congress'); //featured
        $scope.storageChange(true, 'governor'); //featured
        $scope.storageChange(true, 'secretary'); //featured
        $scope.storageChange(false, 'treasurer');
        $scope.storageChange(false, 'controller');
        $scope.storageChange(false, 'attorney');
        $scope.storageChange(true, 'senate'); //featured
        $scope.storageChange(false, 'assembly');
        $scope.storageChange(true, 'county'); //featured
        $scope.storageChange(false, 'administrator');
        $scope.storageChange(false, 'supreme');
        $scope.storageChange(false, 'constable');
        $scope.storageChange(false, 'judge');
        $scope.storageChange(false, 'regent');
        $scope.storageChange(false, 'board');
        $scope.storageChange(false, 'trustee');
        $scope.storageChange(false, 'sheriff');
        $scope.storageChange(false, 'peace');
        $scope.storageChange(true, 'question'); //featured


    };
    //***************************************************************









    //***************************************************************
    //Ensuring consistent race placement order
    $scope.consistency = function () {

        //if every single filter is active, then show the -allResults- and hide the -filteredResults-
        if ($scope.turnout == true && $scope.congress == true && $scope.governor == true && $scope.secretary == true && $scope.treasurer == true &&
        $scope.controller == true && $scope.attorney == true && $scope.senate == true && $scope.assembly == true && $scope.county == true &&
        $scope.administrator == true && $scope.supreme == true && $scope.constable == true && $scope.judge == true && $scope.regent == true &&
        $scope.board == true && $scope.trustee == true && $scope.sheriff == true && $scope.peace == true && $scope.question == true) {

            $scope.allResults = true;
            $scope.filteredResults = false;

            console.log('true result - show the allResults & hide the filteredResults');
        } else { //else show the filtered results and hide the allResults grid

            $scope.allResults = false;
            $scope.filteredResults = true;

            console.log('false result - hide the allResults & show the filteredResults');
        }

    };
    //***************************************************************


    //***************************************************************
    //Displaying the noContest AlertBox if no races
    $scope.alertBox = function () {

        //if every single filter is hidden, then show the noContest AlertBox
        if ($scope.turnout == false && $scope.congress == false && $scope.governor == false && $scope.secretary == false && $scope.treasurer == false &&
        $scope.controller == false && $scope.attorney == false && $scope.senate == false && $scope.assembly == false && $scope.county == false &&
        $scope.administrator == false && $scope.supreme == false && $scope.constable == false && $scope.judge == false && $scope.regent == false &&
        $scope.board == false && $scope.trustee == false && $scope.sheriff == false && $scope.peace == false && $scope.question == false) {

            //show the noContestAlert box
            document.getElementById("noContestAlert").style.display = "block";

        } else { //else hide the alert

            //show the noContestAlert box
            document.getElementById("noContestAlert").style.display = "none";
            
        }

    };
    //***************************************************************



    //call for consistency check
    $scope.consistency();

    //call for alert box check  
    $scope.alertBox();


})