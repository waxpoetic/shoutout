$(document).on 'page:load' ->
  $('.episodes .delete.button').on 'ajax:success', ->
    $(this).closest('.episode').fadeOut(250).remove()

  $(document).on 'ajax:success', '#dialog form', ->
    $('#dialog').foundation('reveal', 'close')
