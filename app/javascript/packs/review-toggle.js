document.querySelectorAll(".review-click").forEach((button) => { 
  button.addEventListener("click", (e) => {
    e.currentTarget.nextElementSibling.classList.toggle('hide')
  });
});