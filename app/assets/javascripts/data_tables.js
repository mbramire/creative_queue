$(document).ready(function(){
  
  $('table').each(function(){
    var display = 15;
    if ($(this).find('tr').length > display + 1){
      $(this).dataTable( {"iDisplayLength": display});
    }
  });


  $(".tabs").children("li").on("click", function(){
    var tab = $(this),
      dataTbl = tab.parent("ul").siblings(".dataTables_wrapper");

    if (!tab.hasClass("tab-on")){
      tab.siblings("li").toggleClass("tab-on");
      tab.toggleClass("tab-on");
      $(".virtual-tbl").toggle();
      dataTbl.toggle();
    };
  });

  $("#virtual_request_unformatted_date").datepicker({beforeShowDay: $.datepicker.noWeekends});
});