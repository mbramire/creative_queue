$(document).ready(function(){
    $('a.prev-btn').click(function(){
        parent.history.back();
        return false;
    });
});