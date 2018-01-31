//= require libs/cartLib.js
//= require libs/modalLib.js

document.addEventListener("turbolinks:load", function () {
    modalLib.init();
});

ready(function () {

    cartLib.load();

    // Delegated click listener
    document.addEventListener("click", function (event) {
        var target = event.target;
        if (containsSelector(target, ".cart-toggle")) {
            try {
                modalLib.toggle("add-to-cart");
            } catch (e) {
                console.error(e);
            }
        }
    });

});

