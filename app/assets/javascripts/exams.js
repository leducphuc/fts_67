function getTimeRemaining(remaining_time) {
  remaining_time.total = remaining_time.total - 1;
  remaining_time.seconds = Math.floor(remaining_time.total % 60);
  remaining_time.minutes = Math.floor(remaining_time.total / 60 % 60);
  return remaining_time;
}

function initializeClock(clock, remaining_time, status) {
  var minutesSpan = clock.querySelector('.minutes');
  var secondsSpan = clock.querySelector('.seconds');

  function updateClock() {

    remaining_time = getTimeRemaining(remaining_time);

    minutesSpan.innerHTML = ('0' + remaining_time.minutes).slice(-2);
    secondsSpan.innerHTML = ('0' + remaining_time.seconds).slice(-2);

    if (remaining_time.total <= 0 && status === 'testing') {
      clearInterval(timeinterval);
      document.getElementById('submit').click();
    }
  }

  updateClock();
  if (status === 'testing'){
    var timeinterval = setInterval(updateClock, 1000);
  }
}

var c_div = document.getElementById('clockdiv');
var mini_div = document.getElementById('minicounter');
var ct_div = c_div !== null ? c_div : mini_div !== null ? mini_div : null;

if (ct_div !== null) {
  var remain_div = document.getElementById('remaining-times');
  var spent_div = document.getElementById('spent-time');
  var status_div = document.getElementById('status');
  if(remain_div !== null) {
    var remain = remain_div.firstChild.textContent;
    var remaining_time = {total: parseInt(remain) + 1, minutes: 0, seconds: 0};
    var status = status_div.firstChild.textContent;
    initializeClock(ct_div, remaining_time, status);
  } else if(spent_div !== null) {
    var spent = spent_div.firstChild.textContent;
    var spent_time = spent.firstChild.textContent;
    var status = status_div.firstChild.textContent;
    initializeClock(ct_div, spent_time, status);
  }
}
