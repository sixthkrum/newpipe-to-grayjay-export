# frozen_string_literal: true

class StreamHistory < ActiveRecord::Base
  self.table_name = "stream_history"

  belongs_to :stream
end
