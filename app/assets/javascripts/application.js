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
  $(".spinner").show();
};

var spinOff = function(){
  $(".spinner").hide();
};

var displayErrors = function() {
  if (typeof flashError !== "undefined") {
    $(".errors").html(flashError);
  }
};

var confirm_destroy = function(element, action) {
  if (confirm("Are you sure?")) {
    var f = document.createElement('form');
    f.style.display = 'none';
    element.parentNode.appendChild(f);
    f.method = 'POST';
    f.action = action;
    var m = document.createElement('input');
    m.setAttribute('type', 'hidden');
    m.setAttribute('name', '_method');
    m.setAttribute('value', 'delete');
    f.appendChild(m);
    f.submit();
  }
  return false;
}

var addTime = function(id) {
 $(".time-group").append("<label for='" + id + "'>Time" + id + ":</label><input id='" + id + "' type='time' name='times[]' value=''>"); 
};

$(document).on("ajax:before", function(event){
  spinOn();
});

$(document).on("ajax:complete", function(event){
  spinOff();
  displayErrors(); 
  console.log("In Ajax:complete!");
})

$(document).on('page:fetch', function() {
  spinOn();
});

$(document).on('page:change', function() {
  spinOff();
  
  $("body").on("click", ".show-modal", function(event){
    event.preventDefault();
    window.modal.show();
    window.modal.test = window.modal.test + 1;
    console.log(window.modal.test);
  });

  $(".modal").on("click", function(event){

    $target = $(event.target);
    console.log($target);

    if($target.is(".modal") || $target.is(".modal-close-button")){
      event.preventDefault();
      window.modal.hide();
    }
  });
  
  // Reminders/_form
  $('select#remindable-type').select2({
    placeholder: "Select Type..",
    allowClear: true
  });
  
  $('.plus').click(function(data) {
    var id = $('.time-input > input:last-child').attr('id');
    id = parseInt(id) + 1;
    
    if (id < 10) {
      addTime(id);  
    }
    
  });
});

window.modal = {
  show: function(){
    $("body").addClass("has-active-modal");
  },
  hide: function(){
    $("body").removeClass("has-active-modal");
  },
  test: 1
};

