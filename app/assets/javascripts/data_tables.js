$(document).ready(function(){
  
  $('table').each(function(){
    var display = 10;
    if ($(this).find('tr').length > display + 1){
      $(this).dataTable( {"iDisplayLength": display});
    }
  });


  $(".tabs").children("li").on("click", function(){
    var tab = $(this),
      table = "." + tab.data("table");

    if (!tab.hasClass("tab-on")){
      tab.siblings("li").removeClass("tab-on")
      tab.addClass("tab-on");
      $(".virtual-tbl-container").hide();
      $(table).show();
    };
  });
});