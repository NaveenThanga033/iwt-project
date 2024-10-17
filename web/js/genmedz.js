
const days=document.getElementById("days");
const hours=document.getElementById("hours");
const minutes=document.getElementById("minutes");
const seconds=document.getElementById("seconds");

const updatetime=()=>{
    const currentyear=new Date().getFullYear()
    const newyear=new Date(`August 15 ${currentyear} 00:00:00`)
    const currentdate=new Date()
    const diff=newyear-currentdate
    const ds=Math.floor(diff/1000/60/60/24);
    const hs=Math.floor((diff/1000/60/60)%24);
    const ms=Math.floor((diff/1000/60)%60);
    const s=Math.floor((diff/1000)%60);
    days.innerText=ds<10?"0"+ds+":":ds+":";
    hours.innerText=hs<10?"0"+hs+":":hs+":";
    minutes.innerText=ms<10?"0"+ms+":":ms+":";
    seconds.innerText=s<10?"0"+s:s;
}

setInterval(updatetime,1000);

let wishlist = JSON.parse(localStorage.getItem('wishlist')) || [];

function addToWishlist(productId) {
    const productElement = document.getElementById(productId).closest('.arrival-cards');
    const product={
        id: productId,
        html: productElement.outerHTML 
    }
    if (!wishlist.find(item => item.id === productId)) {
        wishlist.push(product);
        localStorage.setItem('wishlist', JSON.stringify(wishlist));
        alert(`Product added to wishlist!`);
    } else {
        alert(`This product is already in your wishlist.`);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    let heartButtons = document.querySelectorAll(".heart");

    heartButtons.forEach(function(btn) {
        btn.addEventListener("click", function() {
            this.classList.toggle('color1');

            const productElement = this.closest('.description');
            const productId = productElement.id;

            if (!wishlist.find(item => item.id === productId)) {
                addToWishlist(productId);
            } else {
                alert(`${productElement.querySelector('p').innerText} is already in your wishlist.`);
            }
        });
    });
});

