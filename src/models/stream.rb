# frozen_string_literal: true

class Stream < ActiveRecord::Base
  has_many :playlist_stream_joins, foreign_key: :stream_id
  has_many :playlists, through: :playlist_stream_joins
end
