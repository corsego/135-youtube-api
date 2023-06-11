Play with the Youtube API in your console:

```ruby
require 'google/apis/youtube_v3'

youtube = Google::Apis::YoutubeV3::YouTubeService.new
youtube.key = 'mySecretKey'
channel_id = 'UCyr6ZTmztFW3FB4qG_97FoA'

response = youtube.list_searches('snippet', channel_id: channel_id, max_results: 5, type: 'video')
video_id = response.items.first.id.video_id

response = youtube.list_videos('snippet,contentDetails', id: video_id)

rails g model video title:text description:text duration thumbnail_url:text tags published_at:datetime
```
