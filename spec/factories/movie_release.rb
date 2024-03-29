FactoryBot.define do
  factory :movie_release do
    ptp_movie_id{383_077}
    checked{true}
    codec{"x264"}
    container{"mkv"}
    golden_popcorn{true}
    leechers{0}
    seeders{160}
    quality{"standard definition"}
    release_name{"jurassic.world.2015.x264-sparks"}
    remaster_title{""}
    resolution{"1080p"}
    scene{true}
    snatched{181}
    source{"blu-ray"}
    size{1_609_991_092}
    upload_time{DateTime.parse("Fri, 25 Sep 2015 09:19:09.000000000 +0000")}
  end
end
