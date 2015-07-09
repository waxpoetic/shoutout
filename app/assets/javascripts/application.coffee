#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require foundation
#= require_self
#= require_tree .

$(document).on 'ready page:load', -> $(document).foundation()
