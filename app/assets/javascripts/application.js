// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree .
//= require select2
//= require turbolinks


  var spinOn = function(){
    $(".spinner").show();// addClass("is-spinning");
  };

  var spinOff = function(){
    $(".spinner").hide();// removeClass("is-spinning");
  };
  
  var displayErrors = function() {
    if (flashError) {
      $(".errors").html(flashError);
    }
  };

  $(document).on("ajax:before", function(event){
    console.log("ajax:before");
    spinOn();
  });

  $(document).on("ajax:complete", function(event){
    spinOff();
    displayErrors();
  })

  $(document).on('page:fetch', function() {
    spinOn();
  });
  
  $(document).on('page:change', function() {
    spinOff();
  });

