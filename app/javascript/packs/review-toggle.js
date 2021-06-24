document.querySelectorAll(".review-click").forEach((button) => { 
  button.addEventListener("click", (e) => {
    e.currentTarget.nextElementSibling.classList.toggle('hide')
    const revealElement = e.currentTarget.querySelector("#reveal-info");
    if (revealElement.innerText === "Show Review") {
      revealElement.innerText = "Hide Review";
    } else {
      revealElement.innerText = "Show Review"
    }
  });
});
