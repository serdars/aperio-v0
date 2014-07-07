# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ () ->
  muteNotification = (notification_selector) ->
    $(notification_selector).parent().addClass "text-muted"
    $(notification_selector).parent().find("a").addClass "muted-link"
    $(notification_selector).tooltip "destroy"
    $(notification_selector).addClass "invisible"

  deleteNotifications = (notifications) ->
    $.ajax {
      url: '/notify'
      data:
        ids: notifications
      type: 'POST'
      success: (result) ->
        console.log 'Yay.'
    }

  $(".mark-notification").click (event) ->
    event.preventDefault()
    muteNotification this
    deleteNotifications [ $(this).data("id") ]

  $(".mark-org-notifications").click (event) ->
    event.preventDefault()
    muteNotification this
    muteNotification "[data-organization='" + $(this).data("orgid") + "']"
    deleteNotifications $(this).data("ids")


  $(".mark-all-notifications").click (event) ->
    event.preventDefault()
    muteNotification ".mark-org-notifications"
    muteNotification ".mark-notification"
    muteNotification this
    deleteNotifications $(this).data("ids")
