$(document).ready(function(){
  //event for changing radio buttons
  $('input[id^="quote-radio-"]').on('change', function(){
    show($(this));
  });

  function show(obj){
    if (obj.val() == "yes"){
      $('#sales-select').hide();
      $('#quote-field').show();  
    } else {
      $('#quote-field').hide()
      $('#sales-select').show(); 
    }
  }

  $("#virtual_request_unformatted_date").datepicker({beforeShowDay: $.datepicker.noWeekends, minDate: 0});
});