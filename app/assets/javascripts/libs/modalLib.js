(function (window) {

    "use strict";

    /**
     * Defines the modal lib. Use this lib to toggle modals.
     * @returns {Object}
     */
    function defineLib () {

        var modalLib = {};


        /**
         * Keeps track of all modals currently queued to be displayed.
         * @type {Array}
         */
        var modalQueue = [];


        /**
         * Tracks whether a modal is currently being displayed.
         * @type {boolean}
         */
        var showingModal = false;


        /**
         * Currently active modal.
         */
        var activeModal = null;


        /**
         * A reference to the modal overlay element.
         */
        var overlay;


        /**
         * Initialise the modalLib, inject supporting elements. Call this
         * function on page load if you're using a library like Turbolinks or
         * PJAX.
         */
        modalLib.init = function () {
            // Create overlay
            document.body.insertBefore(
                createFragment("<div class='modal-overlay'></div>"),
                document.body.childNodes[0]
            );
            overlay = document.querySelector(".modal-overlay");
        };


        /**
         * Toggles a modal with the matching identifier. Throws an error if no
         * matching modal is found.
         * @param identifier Modal ID.
         */
        modalLib.toggle = function (identifier) {

            var modal = document.querySelector(".modal#" + identifier);

            // Ensure modal was found
            if (modal === null)
                throw "No modal matching the id '" + identifier + "' could be found.";

            console.debug("Toggling modal with id '" + identifier + "'.");
            toggleModal(modal);

        };


        /**
         * Toggles the given modal element.
         * @param modal Modal element to toggle.
         */
        var toggleModal = function (modal) {
            if (modal.hasAttribute("data-state")) {
                disableModal(modal);
            } else {
                enableModal(modal);
            }
        };


        /**
         * Enables the given modal.
         * @param modal Modal to enable.
         */
        var enableModal = function (modal) {

            // Queue modal if one is already being displayed
            if (showingModal) {
                modalQueue.push(modal);
                console.debug("Queuing modal with id '" + modal.id + "'.");
                return;
            }

            // Activate modal
            modal.setAttribute("data-state", "fading-in");
            setTimeout(function () {
                modal.setAttribute("data-state", "visible");
            }, 300);
            activeModal = modal;

            // Handle overlay
            overlay.setAttribute("data-active", "");
            document.body.style.overflow = "hidden";
            showingModal = true;

            console.debug("Enabled modal with id '" + modal.id + "'.");

        };


        /**
         * Disables the given modal.
         * @param modal Modal to disable.
         */
        var disableModal = function (modal) {

            // Deactivate modal
            modal.setAttribute("data-state", "fading-out");
            setTimeout(function () {
                modal.removeAttribute("data-state");
            }, 300);
            activeModal = null;

            showingModal = false;
            console.debug("Disabled modal with id '" + modal.id + "'.");

            // Check queue
            if (modalQueue.length === 0) {
                overlay.removeAttribute("data-active");
                document.body.style.removeProperty('overflow');
            } else {
                enableModal(modalQueue.shift());
            }

        };


        /**
         * A delegated event listener for document clicks.
         * @param event
         */
        modalLib._onDocumentClick = function (event) {

            var target = event.target;

            // Handle closing modal
            if (target === overlay || hasClass(target, "close-modal-trigger")) {
                disableModal(activeModal);
            }

        };


        return modalLib;

    }

    if (typeof modalLib === "undefined") {
        window.modalLib = defineLib();
        console.debug("Defining modalLib.");
    } else {
        console.debug("modalLib has already been defined.");
    }

})(window);


ready(function () {
    document.addEventListener("click", modalLib._onDocumentClick);
});