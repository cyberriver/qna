$(document).on('turbolinks:load', function() {
    $('form.new-comment').on('ajax:success', function(e){
        var comment = e.detail[0];

        $('.comments').append(comment);
    })

});