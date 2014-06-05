# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ () ->
  $(".mark-notification").click (event) ->
    event.preventDefault()

    # Mark the current element muted
    $(this).parent().addClass "text-muted"
    $(this).parent().find("a").addClass "muted-link"
    $(this).tooltip "destroy"
    $(this).addClass "invisible"

    # Delete the notification
    $.ajax {
      url: '/notifications/' + $(this).data("id")
      type: 'DELETE'
      success: (result) ->
        console.log 'Yay.'
    }
