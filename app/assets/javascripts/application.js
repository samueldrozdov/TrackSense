// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
//= require bootstrap
//= require_tree .

songArray = []
currentlyPlaying = 0;

// Hide header on scroll down, show on scroll up
var didScroll;
var lastScrollTop = 0;
var delta = 70;
var navbarHeight = $('header').outerHeight();

$(window).scroll(function(event){
  didScroll = true;
});

setInterval(function() {
  if (didScroll) {
    hasScrolled();
    didScroll = false;
  }
}, 250);

function hasScrolled() {
  var st = $(this).scrollTop();

  // Make sure they scroll more than delta
  if(Math.abs(lastScrollTop - st) <= delta)
    return;

  // If they scrolled down and are past the navbar, add class .nav-up.
  // This is necessary so you never see what is "behind" the navbar.
  if (st > lastScrollTop && st > navbarHeight){
    // Scroll Down
    $('header').removeClass('nav-down').addClass('nav-up');
  } else {
    // Scroll Up
    if(st + $(window).height() < $(document).height()) {
      $('header').removeClass('nav-up').addClass('nav-down');
    }
  }

  lastScrollTop = st;
}

var mapPlayOnClick = function() {
  if ( $(this).hasClass("playing glyphicon-play")) {
    widget.play();
    $(this).removeClass("glyphicon-play").addClass("glyphicon-pause");
    $("#custom-player-pp").removeClass("glyphicon-play").addClass("glyphicon-pause")
  } else if ( $(this).hasClass("glyphicon-pause") ) {
    widget.pause();
    $(this).removeClass("glyphicon-pause").addClass("glyphicon-play");
    $("#custom-player-pp").removeClass("glyphicon-pause").addClass("glyphicon-play")
  } else {
    $(".currently-playing").removeClass("currently-playing")
    currentlyPlaying = $(this).attr('id').split('-')[1]
    widget.load( songArray[currentlyPlaying] , { auto_play: true });
    console.log( currentlyPlaying );
    $(".playing").removeClass("glyphicon-pause playing").addClass("glyphicon-play");
    $(this).removeClass("glyphicon-play").addClass("glyphicon-pause playing");
    $(".player-meta").text(($("#song-" + Number(currentlyPlaying)).parent().parent()).find(".song-name").text());
    $(this).parent().parent().addClass("currently-playing")
    if($("#custom-player-pp").hasClass("glyphicon-play")) {
      $("#custom-player-pp").removeClass("glyphicon-play").addClass("glyphicon-pause")
    }
  }
}

var ready = function() {

  $("a.fancybox").fancybox({
    'padding'	: 0
  });

  widget = SC.Widget("sc-widget");
  //songArray =  []

  var getSongs = function() {
    $(".song-play-btn").each( function() {
      songArray.push( $(this).attr('id') );
      $(this).attr('id','song-'+(songArray.length -1))
    });
  }

  //getSongs();

  var playNextSong = function( ahead ) {
    $( '.playing' ).removeClass("glyphicon-pause playing").addClass("glyphicon-play");
    currentlyPlaying += ahead ? 1 : -1;
    currentlyPlaying %= songArray.length
    console.log('.song-' + currentlyPlaying)
    $( '#song-' + currentlyPlaying ).removeClass("glyphicon-play").addClass("glyphicon-pause playing");
    $(".player-meta").text(($("#song-" + Number(currentlyPlaying)).parent().parent()).find(".song-name").text());
    widget.load( songArray[currentlyPlaying] , { auto_play: true });
  }

  //attaching event listener to each submission
  //does not handle async added submissions, moved to submission partial
  //$(".song-play-btn").on("click", mapPlayOnClick);

  //attaching listener to custom player - play/pause
  $("#custom-player-pp").on("click", function(){
    if ( $(this).hasClass("glyphicon-play")) {
      widget.play();
      $(this).removeClass("glyphicon-play").addClass("glyphicon-pause");
      $(".playing").removeClass("glyphicon-play").addClass("glyphicon-pause");
    } else if ( $(this).hasClass("glyphicon-pause") ) {
      widget.pause();
      $(this).removeClass("glyphicon-pause").addClass("glyphicon-play");
      $(".playing").removeClass("glyphicon-pause").addClass("glyphicon-play");
    }
  });

  //attaching listener to custom player - next
  $("#custom-player-next").on("click", function(){
    console.log("next song");
    playNextSong(true);
  })

  //attaching listener to custom player - previous
  $("#custom-player-prev").on("click", function(){
    console.log("prev song");
    playNextSong(false);
  })

  //setup automatic play next track
  widget.bind(SC.Widget.Events.FINISH, function() {
    console.log("finished playing!");
    $( ".playing" ).removeClass("glyphicon-pause").addClass("glyphicon-play");
    currentlyPlaying += 1;
    currentlyPlaying %= songArray.length
    // $( '#' + songArray[currentlyPlaying] )
    $("#song-" + currentlyPlaying).removeClass("glyphicon-play").addClass("glyphicon-pause");
    $(".player-meta").text(($("#song-" + Number(currentlyPlaying)).parent().parent()).find(".song-name").text());
    widget.load( songArray[currentlyPlaying] , { auto_play: true });
  });


  //Fade out alert
  window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
    });
  }, 2000);
};

$(document).ready(ready);
$(document).on('page:load', ready);
