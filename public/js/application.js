$(document).ready(function() {
  $("#login_form").click(function(e) {
    e.preventDefault();
    console.log("working?");
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


  $("#survey_title_form").submit(function(e){
    e.preventDefault();
    $.post('/cr eate_new_survey',function(response){
      $("#content").hide();
      $("#content").html(response);
      $("#content").show(response);
    });
  });

});


