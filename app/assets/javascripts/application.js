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


var ready = function() {

  $("a.fancybox").fancybox({
    css: { 'padding' : '0px' }
  });

  widget = SC.Widget("sc-widget");
  songArray =  []
  currentlyPlaying = 0;

  $(".song-play-btn").each( function() {
    songArray.push( $(this).attr('id') );
  });

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
      song = $(this).attr('id')
      currentlyPlaying = $.inArray(song, songArray)
      widget.load( song , { auto_play: true });
      console.log( currentlyPlaying );
      $(".playing").removeClass("glyphicon-pause playing").addClass("glyphicon-play");
      $(this).removeClass("glyphicon-play").addClass("glyphicon-pause playing");
      if($("#custom-player-pp").hasClass("glyphicon-play")) {
        $("#custom-player-pp").removeClass("glyphicon-play").addClass("glyphicon-pause")
      }
    }
  }

  //attaching event listener to each submission
  $(".song-play-btn").on("click", mapPlayOnClick);

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

  

  //setup automatic play next track
  widget.bind(SC.Widget.Events.FINISH, function() {
    console.log("finished playing!");
    $( '.' + songArray[currentlyPlaying] ).removeClass("glyphicon-pause").addClass("glyphicon-play");
    currentlyPlaying += 1;
    $( '.' + songArray[currentlyPlaying] ).removeClass("glyphicon-play").addClass("glyphicon-pause");
    widget.load( songArray[currentlyPlaying] , { auto_play: true });
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
