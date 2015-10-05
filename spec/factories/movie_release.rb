FactoryGirl.define do
  factory :movie_release do
    ptp_movie_id 383077
    checked true
    codec 'x264'
    container 'mkv'
    golden_popcorn true
    leechers 0
    seeders 160
    quality "standard definition"
    release_name "jurassic.world.2015.bdrip.x264-sparks"
    remaster_title "remux / with commentary"
    resolution '720x360'
    scene true
    snatched 181
    source 'blu-ray'
    size 1609991092
    upload_time DateTime.parse("Fri, 25 Sep 2015 09:19:09.000000000 +0000")
    version_attributes ['remux', 'with_commentary']
  end
end
