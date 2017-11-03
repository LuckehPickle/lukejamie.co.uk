// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require local-time
//= require_tree .

document.addEventListener("turbolinks:load", function () {

    var editor = document.querySelector(".CodeMirror");

    if (editor !== null) {
        CodeMirror.fromTextArea(editor, {
            mode: 'markdown',
            indentUnit: 4,
            lineWrapping: true,
            lineNumbers: true
        });
    }


    /**
     * Determines whether the given element has the given class.
     *
     * @param elem Element to check.
     * @param {string} className Class to search for.
     */
    var hasClass = function (elem, className) {
        if (elem.classList) {
            return elem.classList.contains(className);
        } else {
            return new RegExp('(^| )' + className + '( |$)', 'gi').test(elem.className);
        }
    };


    /**
     * Toggles the state of a dropdown.
     * @param event Click event.
     */
    var toggleDropdown = function (event) {

        // Get trigger
        var trigger = event.target;

        // Climb DOM tree until trigger is found
        while (!hasClass(trigger, "dropdown-trigger")) {
            trigger = trigger.parentNode;
            // Ensure we don't reach the document body
            if (trigger === document.body) return;
        }

        var dropdown = trigger.nextElementSibling;

        if (dropdown.hasAttribute("active")) {
            dropdown.removeAttribute("active");
        } else {
            dropdown.setAttribute("active", "");
        }

    };


    var dropdownTriggers = document.querySelectorAll(".dropdown-trigger");

    dropdownTriggers.forEach(function (trigger) {
        trigger.addEventListener("click", toggleDropdown);
    });

});