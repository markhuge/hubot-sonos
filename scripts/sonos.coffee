# Description:
#   Control your sonos device from hubot
#
# Commands:
#   hubot what's playing - Return current track
#   hubot play  - play
#   hubot pause - pause
#   hubot next  - next
#   hubot previous - back
#   hubot back     - back
#   hubot volume <0-100> - set volume
#
# Configuration:
#   HUBOT_SONOS_HOST - the address of your Sonos device
# 
# Author:
#   markhuge


{Sonos} = require 'sonos'
s = new Sonos(process.env.HUBOT_SONOS_HOST)

nowPlaying = (msg) ->
  s.currentTrack (err, track) ->
    msg.send track.artist + " - " + track.title
    msg.send track.albumArtURI

module.exports = (robot) ->
    robot.respond /what'?s playing\??/i, (msg) ->
        nowPlaying msg
    robot.respond /pause/i, (msg) ->
        s.pause() 
    robot.respond /play(.*)/i, (msg) ->
        s.play()
    robot.respond /next(.*)/i, (msg) ->
        s.next()
    robot.respond /back(.*)/i, (msg) ->
        s.previous()
    robot.respond /previous/i, (msg) ->
        s.previous()
    robot.respond /volume (.*)/i, (msg) ->
        loudness = msg.match[1]
        s.setVolume loudness
