$(document).ready(function(){

  $('a.link-style').on('click', function(){
    $('a.link-style-active').attr('class', 'link-style');
    $(this).attr('class' , 'link-style-active');
  })

});
