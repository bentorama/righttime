document.querySelectorAll(".filter-button").forEach((button) => {
  button.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("filter-button-active");
  });
});
