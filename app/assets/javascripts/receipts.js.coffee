# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $("form")
      .bind "ajax:beforeSend", (event, data) ->
        console.log 'loading...'

    $("form")
      .live "ajax:success", (event, data, status, xhr) ->
        $(".itemlist").append data
        $(this)[0].reset()
        $("input#item_description").focus()
        $(window).scrollTop($(document).height());

    $("form")
      .live "ajax:complete", (event, data) ->
        console.log 'loading...done'

