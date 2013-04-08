$(document).ready(function(){

  $('a.link-style').on('click', function(){
    $('li.li-style-active').attr('class', '');
    $('a.link-style-active').attr('class', 'link-style');
    $(this).parent('li').attr('class' , 'li-style-active');
    $(this).attr('class' , 'link-style-active');
  })

});
