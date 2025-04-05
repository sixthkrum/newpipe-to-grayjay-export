#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'active_record'
Dir["#{__dir__}/models/*"].each { |file| require file }

database = ARGV[0]
ActiveRecord::Base.establish_connection(
  'adapter' => 'sqlite3',
  'database' => database
)

return unless __FILE__ == $0

out_directory = "#{__dir__}/../out/newpipe_to_grayjay_export_#{Time.now.to_i}"
`mkdir -p #{out_directory}/stores`

# Playlists
# Format for Grayjay playlists is:
# ["#{playlist_1_name}\n#{playlist_1_video_1_link}}\n#{playlist_1_video_2_link}"]
puts 'Exporting playlists...'
File.open("#{out_directory}/stores/Playlists", 'w+') do |f|
  playlists = []
  Playlist.all.each do |playlist|
    playlist_string = "#{playlist.name}"
    playlist.streams.each do |stream|
      playlist_string << "\n#{stream.url}"
    end

    playlists << playlist_string
  end

  f.write(JSON.dump(playlists))
end
puts 'Playlists exported!'


# Subscriptions
# format for Grayjay subscriptions is:
# ["#{channel_1_link}"]
puts 'Exporting subscriptions...'
File.open("#{out_directory}/stores/Subscriptions", 'w+') do |f|
  subscriptions = []
  Subscription.all.each do |subscription|
    subscriptions << subscription.url
  end

  f.write(JSON.dump(subscriptions))
end
puts 'Subscriptions exported!'

# History
# format for Grayjay history is:
# "https://www.youtube.com/watch?v=M4gVwUQYjLE|||1743848841|||2250|||Traveling Back to Syria After Dictatorship Fell"
# ["#{video_1_url}|||#{video_1_view_timestamp}|||#{video_1_stream_position}|||#{video_1_title}"]
# The timestamp field is seconds since epoch, NewPipe uses milliseconds since epoch
puts 'Exporting history...'
File.open("#{out_directory}/stores/history", 'w+') do |f|
  history_entries = []
  StreamHistory.all.each do |history_entry|
    stream = history_entry.stream
    history_entry_string = "#{stream.url}"
    history_entry_string << "|||#{history_entry.access_date / 1000}"
    history_entry_string << "|||0"
    history_entry_string << "|||#{stream.title}"

    history_entries << history_entry_string
  end

  f.write(JSON.dump(history_entries))
end
puts 'History exported!'

# Generating zip file
puts 'Creating importable zip...'
`pushd #{out_directory} && zip -r #{out_directory}.zip . && popd`
puts "Importable zip created at: #{File.expand_path("#{out_directory}.zip")}"
