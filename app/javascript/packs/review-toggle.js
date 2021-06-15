 document.querySelectorAll(".review-front").forEach((button) => { 
       button.addEventListener("click", (e) => {
         e.currentTarget.nextElementSibling.classList.toggle('hide')
       });
     });