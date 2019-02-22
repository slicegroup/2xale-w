$(document).ready(function(){
  $('.home-slider').slick({
    slidesToScroll: 1,
    slidesToShow: 1,
    dots: true,
    autoplaySpeed: 4000,
    infinite: true,
    autoplay: true,
    arrows: false
  });

  $('.slider-productos').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '.slider-nav'
  });

  $('.slider-nav').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: '.slider-productos',
    centerMode: true,
    focusOnSelect: true
  });

  const second = 1000,
  minute = second * 60,
  hour = minute * 60,
  day = hour * 24;
  
  let countDown = new Date('Sep 30, 2019 00:00:00').getTime(),
  x = setInterval(function() {
    
    let now = new Date().getTime(),
    distance = countDown - now;
    
      document.getElementById('days').innerText = Math.floor(distance / (day)),
      document.getElementById('hours').innerText = Math.floor((distance % (day)) / (hour)),
        document.getElementById('minutes').innerText = Math.floor((distance % (hour)) / (minute)),
        document.getElementById('seconds').innerText = Math.floor((distance % (minute)) / second);
        
        //do something later when date is reached
        //if (distance < 0) {
          //  clearInterval(x);
          //  'IT'S MY BIRTHDAY!;
      //}
      
    }, second)
});