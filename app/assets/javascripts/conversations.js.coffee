# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ () ->
  launchAlert = (message, confirmationHandler, data) ->
    $("#a-alert-confirm").click (event) ->
      $("#a-alert").modal("hide")
      event.preventDefault()
      confirmationHandler(data)

    $("#a-alert-message").html(message)

    $("#a-alert").modal
      backdrop: "static"
      keyboard: true
      show: true

  $(".a-select-group").click (event) ->
    event.preventDefault()
    $(".a-group-selection").data("id", $(this).data("id"))
    $(".a-group-selection").data("name", $(this).data("name"))
    $(".a-selected-group-name").html($(this).data("name"))

  $(".a-post-conversation").click (event) ->
    $.ajax {
      url: '/conversations.json'
      data:
        title: $("#title").val()
        group: $(".a-group-selection").data("id")
        message: $("#message").val()
      type: 'POST'
      success: (result) ->
        document.location.href = result.uri
    }

  $('.a-post-message').click (event) ->
    $.ajax {
      url: '/conversations/' + $(this).data("conversation") + '/post'
      data:
        message: $("#message").val()
      type: 'POST'
      success: (result) ->
        $(".messages").append(result)
        $("#message").val("")
        $("[data-toggle='tooltip']").tooltip()
    }

  $(".messages").on "click", ".a-delete-post", (event) ->
    launchAlert "You are about to delete a message. <br> Are you sure?", (message) ->
      $.ajax {
        url: '/conversations/' + $(message).data("conversation") + ".json"
        context: message
        data:
          message: $(message).data("id")
        type: 'DELETE'
        success: (result) ->
          $(message).tooltip("destroy")
          $(message).parents(".list-group-item").remove()
          if result.uri
            document.location.href = result.uri
      }
    , this

  $(".delete-conversation-btn").click (event) ->
    event.preventDefault()
    launchAlert "You are about to delete a conversation. <br> Are you sure?", (deleteButton) ->
      $(deleteButton).parent().submit()
    , this
    false
