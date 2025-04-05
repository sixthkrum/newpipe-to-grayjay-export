# frozen_string_literal: true

class Playlist < ActiveRecord::Base
  has_many :playlist_stream_joins, foreign_key: :playlist_id
  has_many :streams, through: :playlist_stream_joins
end
