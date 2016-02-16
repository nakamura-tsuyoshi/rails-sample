# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#query').autocomplete
    delay: 200
    source: (request, response) ->
      $.ajax
        url: "/api/suggest.json"
        type: "get",
        data:{
          query: request.term
        }
        success: (datas) ->
          response datas['result']
