# video_id = 'kW-AEo6V15M'
# x = Youtube::CreateVideoJob.perform_now(video_id)
class Youtube::CreateVideoJob < ApplicationJob
  require 'google/apis/youtube_v3'
  YOUTUBE_KEY = 'mySecretKey'
  queue_as :default

  def perform(video_id)
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = YOUTUBE_KEY
    response = youtube.list_videos('snippet,contentDetails', id: video_id)
    snippet = response.items.first.snippet
    video_hash = {
      title: snippet.title,
      description: snippet.title,
      duration: response.items.first.content_details.duration,
      thumbnail_url: snippet.thumbnails.maxres.url,
      tags: snippet.tags,
    }

    Video.find_or_create_by(video_id: video_id).update(video_hash)
  end
end
