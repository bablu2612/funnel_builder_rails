$( "#funnel-form" ).submit(function( event ) {
    event.preventDefault();
    $('#funnel-form *').filter(':input').each(function(){
      console.log("$(this).val()");
    });
    return false;
});