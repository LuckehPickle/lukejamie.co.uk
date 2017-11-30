//= require utils


/**
 * An event which is fired whenever a select button is clicked.
 * @param event Click event.
 */
var selectButtonClickEvent = function (event) {

    // Climb DOM to find select
    var select = event.target;
    while (!hasClass(select, "select")) {
        select = select.parentNode;
        if (select === document) return;
    }

    // Toggle dropdown
    var dropdown = select.querySelector("ul.options");

    if (dropdown.hasAttribute("active")) {
        dropdown.removeAttribute("active");
    } else {
        closeAllSelects();
        dropdown.setAttribute("active", "");
    }

};


/**
 * Closes all select dropdowns.
 */
var closeAllSelects = function () {
    document.querySelectorAll(".select .options").forEach(function (dropdown) {
        dropdown.removeAttribute("active");
    });
};


ready(function () {

    document.addEventListener("click", function (event) {

        // Get event target
        var target = event.target;

        // Delegated event listener for select buttons
        if (containsSelector(target, ".select-button")) {
            selectButtonClickEvent(event);
        } else {
            closeAllSelects();
        }

    });

});