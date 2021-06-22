document.querySelectorAll("#reveal-info").forEach((card) => {
  card.addEventListener("click", (i) => {
    if (i.currentTarget.innerText === "Show Review") {
      i.currentTarget.innerText = "Hide Review";
    } else {
      i.currentTarget.innerText = "Show Review"
    }
  })
})