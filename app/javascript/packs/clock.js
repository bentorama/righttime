const hand_hr = document.querySelector('.hand.hour');
const hand_min = document.querySelector('.hand.minute');
const hand_sec = document.querySelector('.hand.second');

function tick () {
  const d = new Date();
  // seconds
  let seconds = d.getSeconds();
  const secDeg = ((seconds / 60) * 360) + 90;
  hand_sec.style.transform = `translateY(-50%) rotate(${secDeg}deg)`;
  
  // minutes
  let minutes = d.getMinutes();
  const minDeg = ((minutes / 60) * 360) + ((seconds / 60) * 6) + 90;
  hand_min.style.transform = `translateY(-50%) rotate(${minDeg}deg)`;

  // hour
  let hours = d.getHours();
  const hourDeg = ((hours / 12) * 360) + ((minutes / 60) * 30) + 90;
  hand_hr.style.transform = `translateY(-50%) rotate(${hourDeg}deg)`;
}

tick();
setInterval(tick, 1000);
