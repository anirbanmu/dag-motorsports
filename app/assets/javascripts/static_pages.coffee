# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('body').on 'click', (e) ->
    navLinks = $('#nav-header-links')
    navOpened = navLinks.hasClass('in')
    clickedOn = $(e.target)
    isOutsideNavbar = (clickedOn.parents('#nav-header-links').length == 0)
    if navLinks.hasClass('in') && !clickedOn.hasClass('navbar-toggle') && isOutsideNavbar
      navLinks.collapse('hide')

$(document).on('turbolinks:load', ready)
