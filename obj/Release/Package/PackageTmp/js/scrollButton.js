
//scroll toTop
$(document).ready(function() {

  //onScroll
    $(window).scroll(function() {

        //if the window has scrolled greater than 100 pixels
        if($(this).scrollTop() > 100){
            $('#goTop').stop().animate({
                // top: '20px'   
                // bottom: '20px'   
                bottom: '10px'   
                }, 500);
        }
        else{
            $('#goTop').stop().animate({
               // top: '-100px'    
               bottom: '-100px'   
            }, 500);
        }

    });


    //onClick
    $('#goTop').click(function() {
        $('html, body').stop().animate({
           scrollTop: 0
        }, 500, function() {
           $('#goTop').stop().animate({
               // top: '-100px'    
               bottom: '-100px'    
           }, 500);
        });
    });
});    







//old

// //scroll toTop
// $(document).ready(function() {

// 	//onScroll
//     $(window).scroll(function() {
//         if($(this).scrollTop() > 100){
//             $('#goTop').stop().animate({
//                 // top: '20px'   
//                 // bottom: '20px'   
//                 top: '100px'   
//                 }, 500);
//         }
//         else{
//             $('#goTop').stop().animate({
//                top: '-100px'    
//                // bottom: '100px'   
//             }, 500);
//         }
//     });


//     //onClick
//     $('#goTop').click(function() {
//         $('html, body').stop().animate({
//            scrollTop: 0
//         }, 500, function() {
//            $('#goTop').stop().animate({
//                top: '-100px'    
//            }, 500);
//         });
//     });
// });    
