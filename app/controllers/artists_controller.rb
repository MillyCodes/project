class ArtistsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(ENV["SPOTIFY_KEY"], ENV["SPOTIFY_SECRET"])
  Yt.configure do |config|
    config.api_key = ENV["YOUTUBE_KEY"]
  end
  # token = lastfm.auth.get_token
  # lastfm.session = lastfm.auth.get_session(token: token)['key']


  def index
    if !params[:artist_name].empty?
        lastfm = Lastfm.new(ENV["LASTFM_KEY"], ENV["LASTFM_SECRET"])
        @videos = Yt::Collections::Videos.new
        artistspotify = RSpotify::Artist.search(params[:artist_name])
        @artistlastfm = lastfm.artist.get_info(artist: params[:artist_name], autocorrect: 1)
        
        @artistbio = @artistlastfm["bio"]["content"]
        
        puts artistspotify
        @artist = artistspotify.first
        @tracks = @artist.top_tracks(:US)

        @tracks[0..4].each_with_index do |track, i|
          @videoId = @videos.where(q: "music video for #{@artist.name} #{track.name}", order: 'relevance').first.id
          @videoUrl = "<iframe src='//www.youtube.com/embed/#{@videoId}?autoplay=1' frameborder='0' allowfullscreen></iframe>"
      end
        
        # <% @videoId = @videos.where(q: "music video for #{@artist.name} #{track.name}", order: 'relevance').first.id %>
        # @videoId = @videos.where(q: params[:artist_name], safe_search: 'none').first.id
    else
        redirect_to root_path
    end  
  end
  def new
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end
end
