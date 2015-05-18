jQuery ->
  # When episodes are deleted, fade them out from the table.
  $('.episode .destroy a').on 'ajax:success', (episode, event) ->
    $(event.currentTarget).closest('.episode').fadeOut 250, -> $(this).remove()
