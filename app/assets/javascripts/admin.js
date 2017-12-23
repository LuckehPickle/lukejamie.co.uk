//= require utils
//= require components/checkbox
//= require components/select

var selectedItems = [];


/**
 * Handles a checkbox click event.
 * @param event Click event.
 * @param {function} callback A callback function.
 */
var checkboxClickEvent = function (event, callback) {

    // Get clicked element
    var target = event.target;

    // Climb DOM to reach the parent checkbox
    while (!hasClass(target, "checkbox")) {
        target = target.parentNode;
        if (target === document) return;
    }

    if (callback === undefined) {
        toggleCheckbox(target);
    } else {
        toggleCheckbox(target, callback);
    }

};


/**
 * An event that is fired whenever the checkbox on a list item is clicked.
 * @param event Click event.
 */
var listItemCheckboxClickEvent = function (event) {

    // Add callback function
    checkboxClickEvent(event, function (checkbox, isActive) {

        var listItem = checkbox.parentNode;

        if (isActive) {
            listItem.setAttribute("active", "");
        } else {
            listItem.removeAttribute("active");
        }

        updateListHeader();

    });

};


/**
 * An event that is fired whenever the checkbox on a list header is clicked.
 * @param event
 */
var listHeaderCheckboxClickEvent = function (event) {

    // Add callback function
    checkboxClickEvent(event, function (checkbox, isActive) {

        var items = checkbox.parentNode.parentNode.querySelectorAll(".list-item");
        items.forEach(function (item) {

            var checkbox = item.querySelector(".checkbox");

            // Update checkbox
            if (isActive) {
                setCheckboxState(checkbox, checkboxState.CHECKED);
            } else {
                setCheckboxState(checkbox, checkboxState.UNCHECKED);
            }

            if (isActive) {
                item.setAttribute("active", "");
            } else {
                item.removeAttribute("active");
            }

        });

        updateListHeader();

    });

};


/**
 * Updates the list header on the current page.
 */
var updateListHeader = function () {

    // Get relevant information
    var header   = document.querySelector(".list-header");
    var items    = header.parentNode.querySelectorAll(".list-item");
    var checkbox = header.querySelector(".checkbox");
    var label    = document.querySelector(".selected-item-count");

    var activeItems = 0;
    selectedItems = [];

    // Count the number of active children
    items.forEach(function (item) {
        if (item.hasAttribute("active")) {
            activeItems++;
            selectedItems.push(item.getAttribute("data-id"));
        }
    });

    // Update header checkbox
    if (activeItems === 0) {
        setCheckboxState(checkbox, checkboxState.UNCHECKED);
    } else if (activeItems === items.length) {
        setCheckboxState(checkbox, checkboxState.CHECKED);
    } else {
        setCheckboxState(checkbox, checkboxState.INDETERMINATE);
    }

    // Update selected item count
    label.innerHTML = activeItems + " selected";

    // Update header
    if (activeItems === 0) {
        header.removeAttribute("active");
    } else {
        header.setAttribute("active", "");
    }

};


/**
 * Initialises any markdown editors on the current page.
 */
var initMarkdownEditors = function () {
    var editors = document.querySelectorAll(".CodeMirror");
    editors.forEach(function (editor) {
        CodeMirror.fromTextArea(editor, {
            mode: 'markdown',
            indentUnit: 4,
            lineWrapping: true
        });
    });
};


/**
 * Initialises any checkboxes on the current page.
 */
var initCheckboxes = function () {

    var checkboxes = document.querySelectorAll(".checkbox");

    checkboxes.forEach(function (checkbox) {

        if (hasClass(checkbox.parentNode, "list-item")) {
            checkbox.addEventListener("click", listItemCheckboxClickEvent);
        } else if (hasClass(checkbox.parentNode, "list-header")) {
            checkbox.addEventListener("click", listHeaderCheckboxClickEvent);
        } else {
            checkbox.addEventListener("click", checkboxClickEvent);
        }

    });

};


var toggleMobileNav = function () {

    var mobileBar = document.querySelector(".mobile-bar");
    var navigation = document.querySelector(".navigation");

    if (mobileBar.hasAttribute("active")) {
        mobileBar.removeAttribute("active");
        navigation.removeAttribute("active");
    } else {
        mobileBar.setAttribute("active", "");
        navigation.setAttribute("active", "");
    }

};


var closeMobileNav = function () {

    var mobileBar = document.querySelector(".mobile-bar");
    var navigation = document.querySelector(".navigation");

    mobileBar.removeAttribute("active");
    navigation.removeAttribute("active");

};


/**
 * Initialises mobile navigation dropdown.
 */
var initMobileDropdown = function () {

    document.addEventListener("click", function (event) {

        // Get event target
        var target = event.target;

        // Delegated event listener for select buttons
        if (containsSelector(target, ".mobile-nav-trigger")) {
            toggleMobileNav();
        } else {
            closeMobileNav();
        }

    });

};


/**
 * Initialises date pickers with flatpickr.
 */
var initDateInputs = function () {
    flatpickr(".flatpickr", {
        altInput: true
    });
};


// Code fired every page load
document.addEventListener("turbolinks:load", function () {
    initMarkdownEditors();
    initCheckboxes();
    initDateInputs();
});


ready(initMobileDropdown);