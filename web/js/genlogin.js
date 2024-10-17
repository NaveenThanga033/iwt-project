const sign_in_btn = document.querySelector("#sign-in-btn");
const sign_up_btn = document.querySelector("#sign-up-btn");
const container = document.querySelector(".container");

function showNotification(message) {
  const notification = document.createElement("div");
  notification.classList.add("notification");
  notification.innerText = message;
  document.body.appendChild(notification);

  setTimeout(() => {
    notification.classList.add("hide");
    setTimeout(() => {
      notification.remove();
    }, 300);
  }, 2000);
}

sign_up_btn.addEventListener("click", () => {
  container.classList.add("sign-up-mode");
  alert("Welcome to the Sign Up page!");
  showNotification("Sign Up mode activated!");
});

const style = document.createElement("style");
style.innerHTML = `
  .notification {
    position: fixed;
    top: 20px;
    right: 20px;
    background-color: #4bdaec;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 1rem;
    opacity: 1;
    transition: opacity 0.3s ease-in-out;
    z-index: 100;
  }
  .notification.hide {
    opacity: 0;
  }
`;
document.head.appendChild(style);


sign_in_btn.addEventListener("click", () => {
  container.classList.remove("sign-up-mode");

  alert("Switched to Sign-In Mode!");

  const notification = document.createElement("div");
  notification.style.position = "fixed";
  notification.style.top = "20px";
  notification.style.right = "20px";
  notification.style.padding = "10px 20px";
  notification.style.backgroundColor = "#4bdaec";
  notification.style.color = "#fff";
  notification.style.borderRadius = "5px";
  notification.style.boxShadow = "0px 4px 6px rgba(0, 0, 0, 0.1)";
  notification.innerText = "You are now in Sign-In mode!";

  document.body.appendChild(notification);

  setTimeout(() => {
    notification.remove();
  }, 3000);
});
