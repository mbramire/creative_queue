$(document).ready(function(){
  $("#search_unformatted_date_start").datepicker({ 
      onSelect: function(){
        var cal = $("#search_unformatted_date_start"),
          date = cal.val();

        $("#search_unformatted_date_end").datepicker();
      }
  });
});

