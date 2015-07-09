$(document).on 'page:load', ->
  $('.podcasts .delete.button').on 'ajax:success', ->
    $(this).closest('dd').fadeOut(250).remove()
    $(this).closest('dt').fadeOut(250).remove()
