$(document).on 'page:load' ->
  $('form, a').on 'ajax:complete', (request) ->
    $.each request.getResponseHeader('Flash'), (i, message) ->
      $('#messages').append(
        $('<div data-alert class="alert-box" />')
          .addClass(message.type)
          .text(message.text)
      )
