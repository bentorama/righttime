const more = document.getElementById("see-more");

            more.addEventListener("click", () => {
              document.getElementById("expand").classList.toggle("line-clamp")

              if (more.innerText === "See More") {
                more.innerText = "See Less";
              } else {
                more.innerText = "See More";
              }
            });