
# An enum used to refer to the current state of a checkbox
checkboxState = {
  CHECKED: 'checked',
  UNCHECKED: 'unchecked',
  INDETERMINATE: 'indeterminate'
}

###
Determines whether the given node has the given class.
@param elem Node to check for class.
@param className Class to check for.
@return A boolean indicating whether or not the class was found.
###
hasClass = (elem, className) ->
  if elem.classList
    return elem.classList.contains className
  else
    return new RegExp('(^| )' + className + '( |$)', 'gi').test elem.className


###
Toggles whether a checkbox is currently checked
@param checkbox Checkbox to update
@param bubble Whether the event should bubble to parent elements.
###
toggleCheckbox = (checkbox, bubble) ->

  toActivate = true

  if checkbox.hasAttribute "data-state"
    toActivate = checkbox.getAttribute("data-state") != checkboxState.CHECKED

  if toActivate
    setCheckboxState checkbox, checkboxState.CHECKED
  else
    setCheckboxState checkbox, checkboxState.UNCHECKED

  # Handle list items
  if hasClass(checkbox.parentNode, "list-item") and bubble
    updateListItem checkbox.parentNode, toActivate

  # Handle list header
  if hasClass checkbox.parentNode, "list-header"

    items = checkbox.parentNode.parentNode.querySelectorAll ".list-item"
    items.forEach (item) ->
      box = item.querySelector ".checkbox"
      if toActivate
        setCheckboxState box, checkboxState.CHECKED
      else
        setCheckboxState box, checkboxState.UNCHECKED
      updateListItem box.parentNode, toActivate


###
Sets a checkbox's state.
@param checkbox Checkbox to set state.
@param newState State to set checkbox to
###
setCheckboxState = (checkbox, newState) ->

  icon = checkbox.querySelector "i"

  switch newState
    when checkboxState.CHECKED
      checkbox.setAttribute "active", ""
      icon.innerHTML = "&#xE834;"
    when checkboxState.UNCHECKED
      checkbox.removeAttribute "active"
      icon.innerHTML = "&#xE835;"
    when checkboxState.INDETERMINATE
      checkbox.setAttribute "active", ""
      icon.innerHTML = "&#xE909;"

  checkbox.setAttribute "data-state", newState


###
Bubble an update to a list item.
@param item List item to update.
@param active Whether item should be active.
###
updateListItem = (item, active) ->
  if active
    item.setAttribute("active", "")
  else
    item.removeAttribute("active")

  updateListHeader()


###
Bubble an update to the list header.
###
updateListHeader = () ->

  header = document.querySelector ".list-header"
  items = header.parentNode.querySelectorAll ".list-item"
  checkbox = header.querySelector ".checkbox"

  activeItems = 0

  # Count number of active children
  items.forEach (item) ->
    activeItems++ if item.hasAttribute "active"

  # Update checkbox
  if activeItems == 0
    setCheckboxState checkbox, checkboxState.UNCHECKED
  else if activeItems == items.length
    setCheckboxState checkbox, checkboxState.CHECKED
  else
    setCheckboxState checkbox, checkboxState.INDETERMINATE

  # Update header
  if activeItems == 0
    header.removeAttribute "active"
  else
    header.setAttribute "active", ""


document.addEventListener "turbolinks:load", () ->

  # Set up markdown editors
  editor = document.querySelector ".CodeMirror"
  if editor != null
    CodeMirror.fromTextArea editor,
      mode: 'markdown',
      indentUnit: 4,
      lineWrapping: true,
      lineNumbers: true

  # Set up checkboxes in paginated list
  checkboxes = document.querySelectorAll ".checkbox"

  checkboxes.forEach (check) ->
    check.addEventListener "click", (event) ->
      target = event.target

      # Climb DOM until we reach the parent checkbox object
      while not hasClass(target, "checkbox")
        target = target.parentNode

        # Prevent infinite loop in case of failure
        if target == document
          return

      toggleCheckbox target, true