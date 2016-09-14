class AutocompleteHelper

  constructor: (input) ->
    @input = input
    @source = @input.data('source')

  setEvent: ->
    @input.autocomplete source: @source

$ ->
  if $("[data-behavior='autocomplete']").length
    autocomplete = new AutocompleteHelper $("[data-behavior='autocomplete']")
    autocomplete.setEvent()
