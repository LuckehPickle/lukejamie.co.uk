/**
 * Used to refer to the current state of a checkbox.
 * @enum {string}
 */
var checkboxState = {
    CHECKED:       'checked',
    UNCHECKED:     'unchecked',
    INDETERMINATE: 'indeterminate'
};


/**
 * Toggles the current state of a checkbox.
 * @param {Element} checkbox Checkbox to toggle.
 * @param {function} callback Function to fire whenever the checkbox is toggled.
 */
var toggleCheckbox = function (checkbox, callback) {

    // A flag which tracks whether the checkbox should be activated.
    var shouldActivate = true;

    if (checkbox.hasAttribute("data-state")) {
        shouldActivate = (checkbox.getAttribute("data-state") !== checkboxState.CHECKED);
    }

    // Toggle checkbox state
    if (shouldActivate) {
        setCheckboxState(checkbox, checkboxState.CHECKED);
    } else {
        setCheckboxState(checkbox, checkboxState.UNCHECKED);
    }

    // Fire callback function
    if (callback !== undefined) {
        callback(checkbox, shouldActivate);
    }

};


/**
 * Sets a checkboxes state.
 * @param {Element} checkbox Checkbox element to update.
 * @param {string} state State to set.
 */
var setCheckboxState = function (checkbox, state) {

    var icon = checkbox.querySelector("i");

    switch (state) {
        case checkboxState.CHECKED:
            checkbox.setAttribute("active", "");
            icon.innerHTML = "&#xE834;";
            break;
        case checkboxState.UNCHECKED:
            checkbox.removeAttribute("active");
            icon.innerHTML = "&#xE835;";
            break;
        case checkboxState.INDETERMINATE:
            checkbox.setAttribute("active", "");
            icon.innerHTML = "&#xE909;";
            break;
    }

    checkbox.setAttribute("data-state", state);

};

