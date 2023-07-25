$(document).on('turbolinks:load', function() {
  // Устанавливаем CSRF-Token для всех ajax-запросов
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  $('.questions').on('click', '.edit-question-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    $('form#edit-question-' + questionId).removeClass('hidden');
  });

  $('.questions').on('ajax:success', function(e) {
    var data = e.detail[0];
    var rating = data.rating;
    var resourceId = data.resource_id;
    $('#rating_question_' + resourceId).text('rating'+ rating);      
  });
});