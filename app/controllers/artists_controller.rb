class ArtistsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(ENV["SPOTIFY_KEY"], ENV["SPOTIFY_SECRET"])
  
  # token = lastfm.auth.get_token
  # lastfm.session = lastfm.auth.get_session(token: token)['key']


  def index
    if !params[:artist_name].empty?
        lastfm = Lastfm.new(ENV["LASTFM_KEY"], ENV["LASTFM_SECRET"])
        @videos = Yt::Collections::Videos.new
        artistspotify = RSpotify::Artist.search(params[:artist_name])
        artistlastfm = lastfm.artist.get_info(artist: params[:artist_name])
        
        @artistbio = artistlastfm["bio"]["summary"]
        puts artistspotify
        @artist = artistspotify.first
        @tracks = @artist.top_tracks(:US)
        # @ytvideos = @videos.where(q: params[:artist_name], safe_search: 'none').first.title
    else
        redirect_to root_path
    end  
  end
end
