$(document).ready(function() {
  $("#login_form").click(function(e) {
    e.preventDefault();
    $("#log_in").slideToggle();
  });


    $("#create_survey").click(function(e){
    e.preventDefault();
    $.get('/create_new_survey',function(response){
      $("#content").hide();
      $("#content").html(response);
      $("#content").show(response);
    });
  });


        $("a#results").click(function(e){
    e.preventDefault();
    var url = this.href;
    console.log(url);
    $.get(url,function(response){
      $("#content").hide();
      $("#content").html(response);
      $("#content").show(response);
    });
  });


});


