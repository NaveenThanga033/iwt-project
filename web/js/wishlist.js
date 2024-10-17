
document.addEventListener('DOMContentLoaded', () => {
    let wishlist = JSON.parse(localStorage.getItem('wishlist')) || [];

    function loadWishlist() {
        const container = document.getElementById('container');
        
        if (wishlist.length === 0) {
            container.innerHTML = '<p>Your wishlist is empty.</p>';
            return;
        }

        wishlist.forEach(item => {
            const productDiv = document.createElement('div');
            productDiv.innerHTML = item.html; // Set the stored HTML as the inner content
            container.appendChild(productDiv);
        });
    }

    loadWishlist();
});

