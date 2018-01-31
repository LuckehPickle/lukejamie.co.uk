(function (window) {

    "use strict";

    /**
     * Defines the cart lib. Use this lib to track and manage the state of the
     * user's cart.
     * @returns {Object}
     */
    function defineLib () {

        var cartLib = {};
        var localStorage = window.localStorage;
        var cart = [];

        /**
         * Defines the key used to store and retrieve the cart in local
         * storage.
         * @const {string}
         * */
        var STORAGE_KEY = "luke_jamie_cart";


        /**
         * Saves the cart to local storage.
         */
        cartLib.save = function () {
            localStorage.setItem(
                STORAGE_KEY,
                JSON.stringify(cart)
            );
            console.debug("Saved cart to local storage.");
        };


        /**
         * Loads the cart from local storage.
         */
        cartLib.load = function () {
            var valueInStorage = localStorage.getItem(STORAGE_KEY);

            if (valueInStorage === null) {
                cart = [];
                console.debug("Creating a new cart.");
            } else {
                cart = JSON.parse(valueInStorage);
                console.debug("Parsing and loading cart from storage.");
            }
        };


        /**
         * Adds the specified item to the cart.
         * @param slug Item's unique slug.
         * @param quantity Number of items to include.
         * @param size Product size.
         * @param price Value of a single product, for display purposes only.
         */
        cartLib.addItemToCart = function (slug, quantity, size, price) {

            var found = false;

            // Iterate over cart, looking for pre-existing items
            cart.forEach(function (item) {
                if (item.slug === slug && item.size === size) {
                    item.quantity += quantity;
                    found = true;
                }
            });

            if (found) return;

            // Add new item to cart
            cart.push({
                slug: slug,
                quantity: quantity,
                size: size,
                price: price
            });

            console.debug("Added " + quantity + " " + size + " '" + slug + "' to cart.");
            cartLib.save();

        };


        /**
         * Cart getter.
         * @returns {Array} Cart
         */
        cartLib.getCart = function () {
            return cart;
        };

        return cartLib;
    }

    if (typeof cartLib === "undefined") {
        window.cartLib = defineLib();
        console.debug("Defining cartLib.");
    } else {
        console.debug("cartLib has already been defined.");
    }

})(window);