# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggleTooltip = () ->
  # Sometime toggle is needed for a different control
  # Alternatively use tooltip in these cases
  if window.matchMedia("(min-width: 768px)").matches
    $("[data-toggle='tooltip']").tooltip()
    $("[data-tooltip='tooltip']").tooltip()
  else
    $("[data-toggle='tooltip']").tooltip("destroy")
    $("[data-tooltip='tooltip']").tooltip("destroy")

$ () ->
  toggleTooltip()
  $(window).resize(toggleTooltip)

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
