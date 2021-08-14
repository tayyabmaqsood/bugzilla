# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $('#dropdown_link').click ->
    if $('#dropdown_values').css('display') == 'none'
      $('#dropdown_values').show();
    else
      $('#dropdown_values').hide();




