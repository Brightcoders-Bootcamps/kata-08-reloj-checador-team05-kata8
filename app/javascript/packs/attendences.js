var dateFrom = $("#date_from").datepicker();
var dateTo = $("#date_to").datepicker();

document.onload = function(e) {
    if($(dateFrom).val() != '') {
        dateTo.disabled = true;
    } 
}

dateFrom.on('change', function(e) {
    if(this.value == '') {
        dateTo.prop("disabled", true);
        $("#btnReport").prop("disabled", true);
    }
    else {
        dateTo.prop("disabled", false)
        $("#btnReport").prop("disabled", false);
    }
})

dateTo.on('change', function(e) {
    if(this.value == '') {
        $("#btnReport").prop("disabled", true);
    }
    else {
        $("#btnReport").prop("disabled", false);
    }
})

$("#frmReport").on("submit", function(e) {
    dateFrom.prop("required", true);
    dateTo.prop("required", true);
})