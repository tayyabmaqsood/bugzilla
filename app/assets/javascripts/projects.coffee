# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).ready ->
    $("#project_from").validate({
      rules:{
        projectname:{
          required: true,
          minlength: 3
        },
        project_description : {
          required: true,
          minlength: 5
        }
      },
      messages:{
        projectname:{
          minlength: 'Length of project name should be greater than or equal to three'
        },
        project_description : {
          minlength: 'Length of project name should be greater than or equal to five'
        }
      }
    });

