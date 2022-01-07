
$(document).on("blur","input.pass",function(){
    var message = {oldPass:"Please enter old password",
        newPass:"Please enter new passworde",
        conPass:"Please enter new password again",
        sizeValidation: "Password length must be 4 to 15 characters",
        confirmValidation: "New password and confirm password must be same"
    };
    var id = $(this).attr("id");
    if($.trim($(this).val()) == ""){
        showAlert($(this),message[id]);  
    }else{
        removeAlert($(this));
        if(id == "newPass"){
            if($.trim($(this).val()).length < 4 || $.trim($(this).val()).length > 8){
                showAlert($(this),message["sizeValidation"]);
            }else{
                removeAlert($(this));
                var conPassVal = $("#conPass").val();
                if($.trim($(this).val()) != conPassVal){
                    showAlert("#conPass",message["confirmValidation"]);
                }
            }
        }else if(id == "conPass"){
            var newPassVal = $("#newPass").val();
            if($.trim($(this).val()) != newPassVal){
                showAlert($(this),message["confirmValidation"]);
            }else{
                removeAlert($(this));
            }
        }
    }
// Show alert function ==========
    function showAlert(doc,msg){ 
        $(doc).css("border","1px solid red");
        $("input.pass_submit").prop('disabled', true);
        $(doc).parent().find('label').remove();
        $(doc).parent().append("<label class=validation-error>"+msg+"<label>");
        $(doc).val($(doc).val().trim());
    }

// Remove alert function ==========
    function removeAlert(doc){ // Remove alert
        $(doc).val($(doc).val().trim());//remove extra space
        $(doc).removeAttr("style");
        $("input.pass_submit").prop('disabled', false);
        $(doc).parent().find('label').remove();
 
    }
 });