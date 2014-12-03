

//************************************************************************
//graphColumn Add/Remove

function graphColumn() {

    //let x = the document width, set to '0' (default)
    var x = 0;
    if (self.innerHeight) {
        x = self.innerWidth;
    }
    else if (document.documentElement && document.documentElement.clientHeight) {
        x = document.documentElement.clientWidth;
    }
    else if (document.body) {
        x = document.body.clientWidth;
    }



    //grab the gridview tables that have the mobileRemoveCol class | select 2nd column
    var theMobileTables = $('td:nth-child(2), th:nth-child(2)', 'table.mobileRemoveCol tr');


    //if the window width is less than or equal to 767 | hide & show the column
    if (x <= 767) {
        theMobileTables.addClass("hidden");
    }
    else if (x > 767) {
        theMobileTables.removeClass("hidden");
    }
}
//************************************************************************





//************************************************************************

//Init
function initialize() {


    //SP & Fil Turnout Header Text overrides
    $('*', '#theBody_sp').contents().each(function () {
        if (this.nodeType == 3)
            //manual lang overrides
            this.nodeValue = this.nodeValue.replace("REGISTRATION & TURNOUT", "REGISTRO Y PARTICIPACION ELECTORAL");
    });
    $('*', '#theBody_fil').contents().each(function () {
        if (this.nodeType == 3)
            //manual lang overrides
            this.nodeValue = this.nodeValue.replace("REGISTRATION & TURNOUT", "REHISTRASYON & MGA TAONG NAGSIDALO");
    });



//    //********************************************
//    //********************************************
//    //DEM & REP Graph Column IMG SRC overrides (NP defaults to green gifs)

//    //Changing a NP img to a DEM img--------------

//    //DEM - REPRESENTATIVE IN CONGRESS, DIST 1 (GridView21_ctl02_GridView4)
//    $("#GridView21_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - REPRESENTATIVE IN CONGRESS, DIST 3 (GridView21_ctl04_GridView4)
//    $("#GridView21_ctl04_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - REPRESENTATIVE IN CONGRESS, DIST 4 (GridView21_ctl05_GridView4)
//    $("#GridView21_ctl05_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - GOVERNOR (GridView9_ctl02_GridView4)
//    $("#GridView9_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - LIEUTENANT GOVERNOR (GridView9_ctl04_GridView4)
//    $("#GridView9_ctl04_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE SENATE DISTRICT 8 (GridView10_ctl02_GridView4)
//    $("#GridView10_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 3 (GridView11_ctl03_GridView4)
//    $("#GridView11_ctl03_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 4 (GridView11_ctl04_GridView4)
//    $("#GridView11_ctl04_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 6 (GridView11_ctl07_GridView4)
//    $("#GridView11_ctl07_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 7 (GridView11_ctl08_GridView4)
//    $("#GridView11_ctl08_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 9 (GridView11_ctl09_GridView4)
//    $("#GridView11_ctl09_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 10 (GridView11_ctl10_GridView4)
//    $("#GridView11_ctl10_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 14 (GridView11_ctl11_GridView4)
//    $("#GridView11_ctl11_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 34 (GridView11_ctl16_GridView4)
//    $("#GridView11_ctl16_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - STATE ASSEMBLY DISTRICT 35 (GridView11_ctl17_GridView4)
//    $("#GridView11_ctl17_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - COUNTY COMMISSION DISTRICT E (GridView23_ctl02_GridView4)
//    $("#GridView23_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - COUNTY COMMISSION DISTRICT F (GridView23_ctl04_GridView4)
//    $("#GridView23_ctl04_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - COUNTY COMMISSION DISTRICT G (GridView23_ctl06_GridView4)
//    $("#GridView23_ctl06_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - COUNTY CLERK (GridView23_ctl08_GridView4)
//    $("#GridView23_ctl08_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - COUNTY RECORDER (GridView23_ctl09_GridView4)
//    $("#GridView23_ctl09_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - PUBLIC ADMINISTRATOR (GridView13_ctl02_GridView4)
//    $("#GridView13_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - CONSTABLE, HENDERSON TOWNSHIP (GridView14_ctl02_GridView4)
//    $("#GridView14_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //DEM - CONSTABLE, N. LAS VEGAS TOWNSHIP (GridView14_ctl04_GridView4)
//    $("#GridView14_ctl04_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'dem_pngs');
//        $(this).attr('src', srcpath);
//    });


//    //********************************************
//    //********************************************
//    //Changing a NP img to a REP img--------------

//    //REP - REPRESENTATIVE IN CONGRESS, DIST 1 (GridView21_ctl03_GridView4)
//    $("#GridView21_ctl03_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - REPRESENTATIVE IN CONGRESS, DIST 4 (GridView21_ctl06_GridView4)
//    $("#GridView21_ctl06_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - GOVERNOR (GridView9_ctl03_GridView4)
//    $("#GridView9_ctl03_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - LIEUTENANT GOVERNOR (GridView9_ctl05_GridView4)
//    $("#GridView9_ctl05_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE CONTROLLER (GridView6_ctl02_GridView4)
//    $("#GridView6_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE SENATE DISTRICT 8 (GridView10_ctl03_GridView4)
//    $("#GridView10_ctl03_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE SENATE DISTRICT 9 (GridView10_ctl04_GridView4)
//    $("#GridView10_ctl04_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE SENATE DISTRICT 20 (GridView10_ctl05_GridView4)
//    $("#GridView10_ctl05_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 2 (GridView11_ctl02_GridView4)
//    $("#GridView11_ctl02_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 4 (GridView11_ctl05_GridView4)
//    $("#GridView11_ctl05_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 5 (GridView11_ctl06_GridView4)
//    $("#GridView11_ctl06_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 19 (GridView11_ctl12_GridView4)
//    $("#GridView11_ctl12_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 21 (GridView11_ctl13_GridView4)
//    $("#GridView11_ctl13_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 22 (GridView11_ctl14_GridView4)
//    $("#GridView11_ctl14_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 29 (GridView11_ctl15_GridView4)
//    $("#GridView11_ctl15_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - STATE ASSEMBLY DISTRICT 35 (GridView11_ctl18_GridView4)
//    $("#GridView11_ctl18_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - COUNTY COMMISSION DISTRICT E (GridView23_ctl03_GridView4)
//    $("#GridView23_ctl03_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - COUNTY COMMISSION DISTRICT F (GridView23_ctl05_GridView4)
//    $("#GridView23_ctl05_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - COUNTY COMMISSION DISTRICT G (GridView23_ctl07_GridView4)
//    $("#GridView23_ctl07_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
//    //REP - CONSTABLE, HENDERSON TOWNSHIP (GridView14_ctl03_GridView4)
//    $("#GridView14_ctl03_GridView4 tr td:nth-child(2) img").each(function () {
//        var srcpath = $(this).attr('src');
//        srcpath = srcpath.replace('pngs', 'rep_pngs');
//        $(this).attr('src', srcpath);
//    });
}


//Resize
$(window).resize(function () {

    //check if need to hide the graphColumn
    graphColumn();

});

//Ready
$(function () {

    //call to init
    initialize();

    //check if need to hide the graphColumn
    graphColumn();

});

//************************************************************************