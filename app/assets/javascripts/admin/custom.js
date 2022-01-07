//==================================fade out alert message after 6 seconds====================================================
$(document).ready(function() { 
    $(".alert" ).fadeOut(10000);
  
});


$(document).ready(function() {
    $(document).on("click","#notification_read",function() {
        var id = $(this).attr('data-id');
        $.ajax({
            url: "/admin/notifications/"+id,
            type: "patch",
            data: "",
            success: function(data) {
                $("#notification_"+id).children().removeAttr('style');
                $("#counter").text(data);
            },
            error: function(data) {}
        });
    });

    $(document).on("click","#notification_delete",function() {
        var id = $(this).attr('data-id');
        $.ajax({
            url: "/admin/notifications/"+id,
            type: "delete",
            data: "",
            success: function(data) {
                $("#notification_"+id).remove();
                $("#counter").text(data);
                $("#dataTable").dataTable().fnDestroy();
                $("#dataTable").dataTable();
            },
            error: function(data) {}
        });
    });
});
