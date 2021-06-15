// const deadline = '31/12/2015'
// const id = 'clockdiv';
// const endtime = @event.start_time;

// fetch('http://example.com/movies.json')
//   .then(response => response.json())
//   .then(data => console.log(data));


// fetch('/event', { headers: { accept: "application/json" } })
//       .then(response => response.json())
//       .then((data) => {
//         console.log(data);
//       });



const getTimeRemaining = (endtime) => {
  const total = Date.parse(endtime) - Date.parse(new Date());
  const seconds = Math.floor((total / 1000) % 60);
  const minutes = Math.floor((total / 1000 / 60) % 60);
  // const hours = Math.floor((total / (1000 * 60 * 60)) % 24);
  // const days = Math.floor(total / (1000 * 60 * 60 * 24));

  return {
    total,
    // days,
    // hours,
    minutes,
    seconds
  };
}

const initializeClock = (id, endtime) => {
  const clock = document.getElementById(id);
  // const daysSpan = clock.querySelector('.days');
  // const hoursSpan = clock.querySelector('.hours');
  const minutesSpan = clock.querySelector('.minutes');
  const secondsSpan = clock.querySelector('.seconds');

  const updateClock = () => {
    const t = getTimeRemaining(endtime);

    // daysSpan.innerHTML = ('0' + t.days).slice(-2);
    // hoursSpan.innerHTML = ('0' + t.hours).slice(-2);
    minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
    secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

    if (t.total <= 0) {
      clearInterval(timeinterval);
    }
  }

  updateClock(); 
  var timeinterval = setInterval(updateClock, 1000);
}

initializeClock('clockdiv', obj.start_time)
// initializeClock('clockdiv', start_time)
// export { initializeClock };