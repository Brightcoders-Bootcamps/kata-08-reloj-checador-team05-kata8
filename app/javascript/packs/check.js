var msgFlash = document.getElementById("flashMsg");
if(msgFlash != null) {
    setTimeout(function() {
            msgFlash.classList.add("d-none");
    }, 5000);
}
document.getElementById("btnCheck").disabled = true;

document.getElementById("txtPNumber").oninput = function(e) {
    if(/^\d+$/.test(this.value) == false) {
        document.getElementById("txtPNumber").classList.add("invalid");
        document.getElementById("btnCheck").disabled = true;
        return false;
    }
    document.getElementById("txtPNumber").classList.remove("invalid");
    document.getElementById("btnCheck").disabled = false;

}