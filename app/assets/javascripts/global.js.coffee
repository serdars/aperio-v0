# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ () ->
  $("[data-toggle='tooltip']").tooltip()
  # Sometime toggle is needed for a different control
  # Alternatively use tooltip in these cases
  $("[data-tooltip='tooltip']").tooltip()

  $("[data-toggle='offcanvas']").click () ->
    target = $(this).data("target")
    $(target).toggleClass "active"

  $(".ap-logout").click (event) ->
    $.ajax {
      url: '/logout.json'
      type: 'DELETE'
      success: (result) ->
        if result.uri
          document.location.href = result.uri
    }

  token = $('meta[name="csrf-token"]').attr 'content'

  $.ajaxSetup {
    beforeSend : (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', token
  }
