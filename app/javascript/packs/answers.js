$(document).on('turbolinks:load', function() {
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    $('form#edit-answer-' + answerId).removeClass('hidden');

  })
  
  $('form.new-answer').on('ajax:success', function(e) {
      var answer = e.detail[0];

    $('.answers').append('<p>' + answer.title + '</p>');
  })
    .on('ajax:error', function(e){
      var errors = e.detail[0];
      $.each(errors, function(index,value){
        $(".answer-errors").append('<p> rating:' + value + '</p>')
      })
    })

    $('.answers').on('ajax:success', function(e) {
      var data = e.detail[0];
      var rating = data.rating
      var resourceId = data.resource_id

      $('#rating_answer_' + resourceId).text('rating'+ rating);      
    })
});

