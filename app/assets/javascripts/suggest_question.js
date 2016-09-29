$(document).bind('DOMSubtreeModified', function() {
  $('.rb').click(function() {
    $('.rb').not(this).prop('checked', false).attr('value', 'false');
    $(this).attr('value', 'true');
  });
});

$('#question-submit').click(function(){captureForm()});
$('#suggest-question-submit').click(function(){captureForm()});

function captureForm() {
  $('.rb').prop('checked', true);
}
