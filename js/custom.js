/**
 * Created by Aaron on 5/2/2016.
 */
/**$("#hpSlider").slider({
    orientation: "vertical",
    range: "min",
    min: 0,
    max: 100,
    value: 100,
    slide: function(event, ui) {
        $("#hpValue").val(ui.value+"%");
    }
});
$("#hpValue").val($("#hpSlider").slider("value"));

$("#comboSlider").slider({
    orientation: "vertical",
    range: "min",
    min: 1,
    max: 20,
    value: 1,
    slide: function(event, ui) {
        $("#comboCount").val(ui.value);
    }
});
$("#comboCount").val($("#comboSlider").slider("value"));**/
$(document).ready(function() {
    var ls1toggled = false;
    var ls2toggled = false;
    function leader1toggle() {
        var hp = 0;
        var atk = 0;
        var rcv = 0;
        for (monster in team) {
            atk = monster.getAtk();

        }
        if(!ls1toggled) {

        }
    }
    function leader2toggle() {

    }
    $('[data-toggle="ls1toggle"]').leader1toggle();
    $('[data-toggle="ls2toggle"]').leader2toggle();
    $('[data-toggle="tooltip"]').tooltip();
    $("#hpSlider").slider({
        orientation: "vertical",
        range: "min",
        min: 0,
        max: 100,
        value: 100,
        slide: function(event, ui) {
            $("#hpValue").val(ui.value+"%");
        }
    });
    $("#hpValue").val($("#hpSlider").slider("value"));

    $("#comboSlider").slider({
        orientation: "vertical",
        range: "min",
        min: 1,
        max: 20,
        value: 1,
        slide: function(event, ui) {
            $("#comboCount").val(ui.value);
        }
    });
    $("#comboCount").val($("#comboSlider").slider("value"));
    $("#password2").keyup(function() {
        var password1 = $("#password1").val();
        var password2 = $("#password2").val();
        if(password1 != password2) {
            $("#checkPassword").html("Passwords do not match.").show();
        }
        else {
            $("#checkPassword").hide();
        }
    });
});