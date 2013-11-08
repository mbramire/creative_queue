$(document).ready(function(){
  
  $('table').each(function(){
    var display = 15;
    if ($(this).find('tr').length > display + 1){
      $(this).dataTable( {"iDisplayLength": display});
    }
  });
});