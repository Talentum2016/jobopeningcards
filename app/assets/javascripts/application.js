// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function alert_error(text){
  $.notify(text, {
    delay: 2000 ,
    type: 'danger',
    icon: 'fa fa-ban',
      animate: {
        enter: 'animated bounceInDown',
        exit: 'animated bounceOutUp'
      }
  });
}

function alert_notice(text){
  $.notify(text, {
    delay: 2000 ,
    type: 'success',
    icon: 'fa fa-check',
    animate: {
      enter: 'animated bounceInDown',
      exit: 'animated bounceOutUp'
    }
  });
}