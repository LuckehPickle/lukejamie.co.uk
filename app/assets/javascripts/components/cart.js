document.addEventListener("turbolinks:load", function () {

    var cart = [];
    var localStorage = window.localStorage;
    var cartBody = document.querySelector(".cart-dropdown-body");

    /** @const {string} */
    var STORAGE_KEY = "cart";


    /**
     * Loads the cart from local storage.
     */
    var loadCart = function () {

        // Get cart as it appears in local storage
        var valueInStorage = localStorage.getItem(STORAGE_KEY);

        // Ensure exists
        if (valueInStorage === null) {
            // cart = [];
            cart = [
                {
                    slug: 'swan-t-shirt-white',
                    size: 'medium',
                    quantity: '1'
                }
            ];
        } else {
            cart = JSON.parse(valueInStorage);
        }
    };

    /**
     * Saves the cart to local storage.
     */
    var saveCart = function () {

        // Convert to JSON and store
        localStorage.setItem(
            STORAGE_KEY,
            JSON.stringify(cart)
        );
    };


    /**
     * Updates the carts appearance to reflect its actual state.
     */
    var update = function () {

        if (cartBody === null) return;

        var label = document.querySelector(".items-in-cart");

        loadCart();
        emptyCartVisually();

        // Update label
        label.innerHTML = cart.length + "";

        if (cart.length === 0)
            drawEmptyState();
        else
            renderRemotely();

    };


    /**
     * Removes all drawn items from the cart's body.
     */
    var emptyCartVisually = function () {
        cartBody.innerHTML = "";
    };


    /**
     * Draws an empty state element into the cart dropdown.
     */
    var drawEmptyState = function () {

    };


    /**
     * Sends the state of the cart to the server, so that a HTML response can
     * be returned.
     */
    var renderRemotely = function () {

        var XHR = new XMLHttpRequest();
        var slugs = [];

        cart.forEach(function (value) { slugs.push(value["slug"]); });

        XHR.onreadystatechange = function () {
            if (XHR.readyState === XMLHttpRequest.DONE) {
                if (XHR.status === 200) {
                    // Deal with responds
                } else {
                    // TODO Update cart to warn about error
                    console.log(XHR.statusText + " (" + XHR.status + ")");
                }
            }
        };

        XHR.open("GET", "/products/cart.js?products=" + JSON.stringify(slugs), true);
        XHR.send();

    };


    // update();

});