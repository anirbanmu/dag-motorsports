# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('body').on 'click', (e) ->
    navLinks = $('#nav-header-links')
    navOpened = navLinks.hasClass('in')
    if navLinks.hasClass('in') && !$(e.target).hasClass('navbar-toggle')
      navLinks.collapse('hide')

$(document).on('turbolinks:load', ready)
