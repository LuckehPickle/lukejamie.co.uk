/**
 * Determines whether the given node has the given class.
 * @param {Element} elem Node to check for class.
 * @param {string} className Class to check for.
 * @return {boolean} A boolean indicating whether or not the class was found.
 */
var hasClass = function (elem, className) {
    if (elem.classList) {
        return elem.classList.contains(className);
    } else {
        return new RegExp('(^| )' + className + '( |$)', 'gi').test(elem.className);
    }
};


/**
 * Determines whether the given element matches the given selector.
 * @param {Element} elem Element to test.
 * @param {string} selector Selector to match against.
 */
var matches = function (elem, selector) {
    return (
        elem.matches ||
        elem.matchesSelector ||
        elem.msMatchesSelector ||
        elem.mozMatchesSelector ||
        elem.webkitMatchesSelector ||
        elem.oMatchesSelector
    ).call(elem, selector);
};


/**
 * Determines whether the given element or any of it's parents match the given
 * selector. This is useful for event delegation.
 * @param {Element} elem Element to test for.
 * @param {string} selector Selector to match against elem and it's children.
 */
var containsSelector = function (elem, selector) {

    var temp = elem;

    while (!matches(temp, selector)) {
        temp = temp.parentNode;
        if (temp === document) return false;
    }

    return true;

};


/**
 * Queue a function to be fired only once the DOM is ready.
 * @param {function} func Function to call once the DOM is ready.
 */
var ready = function (func) {
    if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading") {
        func();
    } else {
        document.addEventListener('DOMContentLoaded', func);
    }
};