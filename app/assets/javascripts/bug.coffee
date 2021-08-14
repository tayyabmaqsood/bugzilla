# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  options = $('#bug_bug_type').html()
  $('#bug_bug_type').change ->
    selection = $('#bug_bug_type :selected').text()
    console.log(selection)
    if selection == 'Feature'
        $('#bug_bug_status').append('<option value = "completed">
                                      Completed </options> ')
        $("#bug_bug_status [value = 'resolved']").remove();
    else
      $('#bug_bug_status').append('<option value = "resolved">
                                      Resolved </options> ')
      $("#bug_bug_status [value = 'completed']").remove();

jQuery ->
  $('#button').click ->
    $('#bug_screenshot').click();

  $('#bug_screenshot').change ->
    extension = ($('#bug_screenshot').val()).split('.')[1];
    if ($.inArray(extension,['png','gif']) == -1)
        $('#bug_screenshot').val('');
        $('#error_field').show().text('Please Upload Image in .png, .gif formate else it will not be uploaded');
    else
        $('#error_field').hide()


