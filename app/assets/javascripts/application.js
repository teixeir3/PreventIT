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

var displayNotices = function() {
  if (typeof flashNotice !== "undefined") {
    $(".notices").html(flashNotice);
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

var modalReminderForm = function(remindable_url) {
  $.ajax(remindable_url, {
    success: function(data, b, resp) {

      console.log("In success callback for modalReminderForm!");
      console.log(resp);
    },
    error: function() {
      console.log("Error in modalReminderForm!");
    }
  });  
    
  
};

// Fancy form show edit

var editField = function (event) {
    event.preventDefault();
    var $currentTarget = $(event.currentTarget);
    var field = $currentTarget.data('field');
    var $input = $('<input class="edit-input">');

    $input.data('field', field);
    $input.val(this.model.escape(field));
    $currentTarget.removeClass('editable');
    $currentTarget.html($input);
    $input.focus();
};

var saveField = function (event) {
    event.preventDefault();
    var field = $(event.currentTarget).data('field');
    var newVal = $(event.currentTarget).val();

    this.model.set(field, newVal);
    this.model.save();
    this.render();
};

var ensureUnique = function(description) {
  var isUniq = true;

  $('.unique-choice').each(function(i, el) {
    if (el.text === description) {
      isUniq = false;
    };
  })

  return isUniq;
};

var rowFadeout = function() {
    console.log("in rowFadeout Method!");
    $(this).closest('tr').fadeOut();
  }

$(document).on("ajax:before", function(event){
  spinOn();
});

$(document).on("ajax:success", function(event){
  console.log("In Ajax:Success!");
  
  $('.plus').click(function(event) {
    var id = $('.time-input > input:last-child').attr('id');
    id = parseInt(id) + 1;
    
    if (id < 10) {
      addTime(id);  
    }
  });
});

$(document).on("ajax:complete", function(event){
  spinOff();
  displayErrors();
  displayNotices();
  console.log("In Ajax:complete!");
});

$(document).on('page:fetch', function() {
  spinOn();
});

// Bind event listeners for TurboLinks
$(document).on('page:change', function() {
  console.log("in page:change");
  spinOff();
  
  $('.deletable').bind('ajax:success', rowFadeout);
  
  $(".modal").on("click", function(event){

    $target = $(event.target);

    if($target.is(".modal") || $target.is(".modal-close-button")){
      event.preventDefault();
      window.modal.hide();
    }
  });
  
  // Reminders/_form
  $('select#remindable-type-select2').select2({
    placeholder: "Select Type..",
    allowClear: true
  });
  
  $('.plus').click(function(event) {
    var id = $('.time-input > input:last-child').attr('id');
    id = parseInt(id) + 1;
    
    if (id < 10) {
      addTime(id);  
    }
    console.log("in plus .click handler ");
  });
  
  $(".editField").on("dblclick", function(event) {
    editField(event);
  });
  
  $(".saveField").on("blur", function(event) {
    editField(event);
  });
});

window.modal = {
  show: function(){
    $("body").addClass("has-active-modal");
  },
  hide: function(){
    $("body").removeClass("has-active-modal");
  },
  swapContent: function(htmlString) {
    $("#modal-container").html(htmlString);
  
    window.modal.show();
  }
};

