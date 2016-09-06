class Editor

  constructor: (editorId, inputDataAttr, submitIdDataAttr) ->
    @editor = editor
    @input = document.querySelector('[data-behavior=' + inputDataAttr + ']')
    @submit = document.querySelector('[data-behavior=' + submitIdDataAttr + ']')

  initEditor: ->
    aceEditor = ace.edit(editor)
    aceEditor.setTheme('ace/theme/monokai')
    aceEditor.getSession().setMode('ace/mode/json')
    aceEditor.getSession().setTabSize(2)
    aceEditor.getSession().setUseSoftTabs(true)
    aceEditor.getSession().on 'change', (e) ->
      value = aceEditor.getValue()
      if @isJsonString(value)
        @submit.removeAttribute('disabled')
        @input.setValue value
      else
        @submit.setAttribute('disabled')
  
  isJsonString: (str) =>
    try
      JSON.parse str
    catch e
      false
    true

jQuery ->
  new Editor('editor', 'json-value', 'submit-btn').initEditor();
