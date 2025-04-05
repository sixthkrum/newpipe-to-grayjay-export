# frozen_string_literal: true

class PlaylistStreamJoin < ActiveRecord::Base
  self.table_name = 'playlist_stream_join'

  belongs_to :playlist, class_name: 'Playlist'
  belongs_to :stream, class_name: 'Stream'
end