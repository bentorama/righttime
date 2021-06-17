document.querySelectorAll(".review-click").forEach((button) => { 
  button.addEventListener("click", (e) => {
    // document.querySelector('.hide').style.padding = "10px";
    e.currentTarget.nextElementSibling.classList.toggle('hide')
  });
});