# superails_channel_id = 'UCyr6ZTmztFW3FB4qG_97FoA'
# Youtube::ListVideosJob.perform_now(superails_channel_id)
class Youtube::ListVideosJob < ApplicationJob
  require 'google/apis/youtube_v3'
  YOUTUBE_KEY = 'mySecretKey'
  queue_as :default

  def perform(channel_id)
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = YOUTUBE_KEY

    videos_ids = []
    next_page_token = nil
    loop do
      response = youtube.list_searches('snippet', channel_id: channel_id, max_results: 50, type: 'video', page_token: next_page_token)
      response_ids = response.items.map { |item| item.id.video_id }.compact
      videos_ids += response_ids
      next_page_token = response.next_page_token
      break if next_page_token.nil?
    end

    videos_ids.each do |video_id|
      Youtube::CreateVideoJob.perform_now(video_id)
    end
  end
end
