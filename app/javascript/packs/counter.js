const plus = document.getElementById("plus");
const minus = document.getElementById("minus");
const counterHtml = document.getElementById("counter-Html");
let counter = Number.parseInt(document.getElementById("counter-Html").innerText);
const priceHtml = document.getElementById("price-html");
let price = Number.parseInt(document.getElementById("price-html").innerText);
let ticketPrice = Number.parseInt(document.getElementById("price-html").innerText);


plus.addEventListener("click", (event) => {
  event.preventDefault();
  counter++;
  counterHtml.innerText = counter;
  price += ticketPrice;
  priceHtml.innerText = price;
});
  
minus.addEventListener("click", (event) => {
  event.preventDefault();
  if (counter < 2) {
    minus.disabled = true;
  } else {
    counter -= 1;
    counterHtml.innerText = counter;
    price -= ticketPrice;
    priceHtml.innerText = price;
  }
});
