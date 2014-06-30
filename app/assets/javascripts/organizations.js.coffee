# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ () ->
  $(".ap-org-summary").click (event) ->
    document.location.href = $(this).data("organization-uri")
