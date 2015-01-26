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

var ready = function() {

  $("a.fancybox").fancybox({
    'padding'	: 0
  });

  widget = SC.Widget("sc-widget");
  //songArray =  []
  currentlyPlaying = 0;

  var getSongs = function() {
    $(".song-play-btn").each( function() {
      songArray.push( $(this).attr('id') );
      $(this).attr('id','song-'+(songArray.length -1))
    });
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
      currentlyPlaying = $(this).attr('id').split('-')[1]
      widget.load( songArray[currentlyPlaying] , { auto_play: true });
      console.log( currentlyPlaying );
      $(".playing").removeClass("glyphicon-pause playing").addClass("glyphicon-play");
      $(this).removeClass("glyphicon-play").addClass("glyphicon-pause playing");
      $(".player-meta").text($("#submission-" + (Number(currentlyPlaying)+1)).find(".song-name").text());
      if($("#custom-player-pp").hasClass("glyphicon-play")) {
        $("#custom-player-pp").removeClass("glyphicon-play").addClass("glyphicon-pause")
      }
    }
  }

  //getSongs();

  var playNextSong = function( ahead ) {
    $( '.playing' ).removeClass("glyphicon-pause playing").addClass("glyphicon-play");
    currentlyPlaying += ahead ? 1 : -1;
    currentlyPlaying %= songArray.length
    console.log('.song-' + currentlyPlaying)
    $( '#song-' + currentlyPlaying ).removeClass("glyphicon-play").addClass("glyphicon-pause playing");
    $(".player-meta").text($("#submission-" + (Number(currentlyPlaying)+1)).find(".song-name").text());
    widget.load( songArray[currentlyPlaying] , { auto_play: true });
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
    $(".player-meta").text($("#submission-" + (Number(currentlyPlaying)+1)).find(".song-name").text());
    widget.load( songArray[currentlyPlaying] , { auto_play: true });
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
