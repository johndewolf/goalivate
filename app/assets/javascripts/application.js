// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jqplot
//= require_tree .
//= require_self

$(function(){
  $(document).foundation();
    setTimeout(function(){ $('.alert-box').fadeOut() }, 5000);
  $('#resizable1').bind('resize', function(event, ui) {
        plot1.replot( { resetAxes: true } );
    });

  $(".pagination a").live("click", function() {
    $(".pagination").html("Checkpoints are loading");
    $.getScript(this.href);
    return false;
  });
});
});
