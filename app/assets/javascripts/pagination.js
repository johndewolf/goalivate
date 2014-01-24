$(function (){
    $('.pagination a').live(function (){
      $.get(this.href, null, null, 'script');
      $('.pagination').html('Checkpoints are loading...');
      return false;
    });
});
