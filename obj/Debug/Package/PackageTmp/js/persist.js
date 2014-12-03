





////Yes - document.location = "http://my.new.url.com"

////Retrieval

////var myURL = document.location;
////document.location = myURL + "?a=parameter";
////The location object has a number of useful properties too:

////hash            Returns the anchor portion of a URL
////host            Returns the hostname and port of a URL
////hostname        Returns the hostname of a URL
////href            Returns the entire URL
////pathname        Returns the path name of a URL
////port            Returns the port number the server uses for a URL
////protocol        Returns the protocol of a URL
////search          Returns the query portion of a URL



////check the incoming url for restful parameters & display sections + set $scope bools as needed
//$(function () {

//    //http://gisgate.co.clark.nv.us/openweb?getparcel=04121501002 




//    var myUrl = document.location;

//    console.log(myUrl.pathname);    




//    filterRedirect();


//});





////***********************Filter Redirect***********************************

////Make the call to find APN if redirected with getparcel
//function filterRedirect() {

//    if (document.URL.indexOf("getparcel") > -1) {
//        //strip numericals
//      //  var theParcel = document.URL.replace(/^\D+/g, '');

//        //call to redirect to parcel
//       // ajaxAPN(theParcel);
//    }
//    





////	if (document.URL.indexOf("getparcel") > -1)
////	{
////		//strip numericals
////		var theParcel = document.URL.replace( /^\D+/g, '');

////		//call to redirect to parcel
////		ajaxAPN(theParcel);
////	}
//}
////************************************************************************





