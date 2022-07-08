# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `themoviedb` gem.
# Please instead update this file by running `bin/tapioca gem themoviedb`.

module Tmdb; end

class Tmdb::Api
  include ::HTTParty
  include ::HTTParty::ModuleInheritableAttributes
  extend ::HTTParty::ClassMethods
  extend ::HTTParty::ModuleInheritableAttributes::ClassMethods

  class << self
    def config; end
    def default_cookies; end
    def default_cookies=(_arg0); end
    def default_options; end
    def default_options=(_arg0); end
    def etag(etag); end
    def key(api_key); end
    def language(lang); end
    def response; end

    # @raise [Tmdb::InvalidApiKeyError]
    def set_response(hash); end
  end
end

class Tmdb::Collection < ::Tmdb::Resource
  def backdrop_path; end
  def backdrop_path=(_arg0); end
  def id; end
  def id=(_arg0); end
  def name; end
  def name=(_arg0); end
  def parts; end
  def parts=(_arg0); end
  def poster_path; end
  def poster_path=(_arg0); end

  class << self
    # Get all of the images for a particular collection by collection id.
    def images(id, _conditions = T.unsafe(nil)); end
  end
end

class Tmdb::Company < ::Tmdb::Resource
  def description; end
  def description=(_arg0); end
  def headquarters; end
  def headquarters=(_arg0); end
  def homepage; end
  def homepage=(_arg0); end
  def id; end
  def id=(_arg0); end
  def logo_path; end
  def logo_path=(_arg0); end
  def name; end
  def name=(_arg0); end
  def parent_company; end
  def parent_company=(_arg0); end

  class << self
    # Get the list of movies associated with a particular company.
    def movies(id, _conditions = T.unsafe(nil)); end
  end
end

class Tmdb::Configuration
  # @return [Configuration] a new instance of Configuration
  def initialize; end

  def backdrop_sizes; end

  # To build an image URL, you will need 3 pieces of data.
  # The base_url, size and file_path.
  # Simply combine them all and you will have a fully qualified URL. Here’s an example URL:
  # http://cf2.imgobject.com/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg
  def base_url; end

  def fetch_response; end
  def logo_sizes; end
  def poster_sizes; end
  def profile_sizes; end

  # HTTPS
  def secure_base_url; end

  private

  def images_config; end
end

class Tmdb::Episode < ::Tmdb::Resource
  class << self
    # Get the TV episode cast credits by combination of season and episode number.
    def cast(id, season, episode, _conditions = T.unsafe(nil)); end

    # Get the TV episode crew credits by combination of season and episode number.
    def crew(id, season, episode, _conditions = T.unsafe(nil)); end

    # Get the primary information about a TV episode by combination of a season and episode number.
    def detail(id, season, episode, conditions = T.unsafe(nil)); end

    # Get the external ids for a TV episode by comabination of a season and episode number.
    def external_ids(id, season, episode, _conditions = T.unsafe(nil)); end

    # Get the images (episode stills) for a TV episode by combination of a season and episode number.
    def images(id, season, episode, _conditions = T.unsafe(nil)); end
  end
end

class Tmdb::Find < ::Tmdb::Resource
  class << self
    def freebase_id(id, _conditions = T.unsafe(nil)); end
    def freebase_mid(id, _conditions = T.unsafe(nil)); end
    def imdb_id(id, _conditions = T.unsafe(nil)); end
    def tvdb_id(id, _conditions = T.unsafe(nil)); end
    def tvrage_id(id, _conditions = T.unsafe(nil)); end
  end
end

class Tmdb::Genre
  # @return [Genre] a new instance of Genre
  def initialize(attributes = T.unsafe(nil)); end

  def get_page(page_number, conditions = T.unsafe(nil)); end
  def id; end
  def id=(_arg0); end
  def name; end
  def page; end
  def page=(_arg0); end
  def results; end
  def results=(_arg0); end
  def total_pages; end
  def total_pages=(_arg0); end
  def total_results; end
  def total_results=(_arg0); end

  class << self
    def detail(id, conditions = T.unsafe(nil)); end
    def find(query); end
    def list; end
    def search(query); end
  end
end

class Tmdb::InvalidApiKeyError < ::StandardError; end

class Tmdb::Job
  # @return [Job] a new instance of Job
  def initialize(attributes = T.unsafe(nil)); end

  def department; end
  def department=(_arg0); end
  def name; end
  def name=(_arg0); end

  class << self
    def list; end
  end
end

class Tmdb::Movie < ::Tmdb::Resource
  def adult; end
  def adult=(_arg0); end
  def alternative_titles; end
  def alternative_titles=(_arg0); end
  def backdrop_path; end
  def backdrop_path=(_arg0); end
  def belongs_to_collection; end
  def belongs_to_collection=(_arg0); end
  def budget; end
  def budget=(_arg0); end
  def changes; end
  def changes=(_arg0); end
  def credits; end
  def credits=(_arg0); end
  def genres; end
  def genres=(_arg0); end
  def homepage; end
  def homepage=(_arg0); end
  def id; end
  def id=(_arg0); end
  def images; end
  def images=(_arg0); end
  def imdb_id; end
  def imdb_id=(_arg0); end
  def keywords; end
  def keywords=(_arg0); end
  def lists; end
  def lists=(_arg0); end
  def original_title; end
  def original_title=(_arg0); end
  def overview; end
  def overview=(_arg0); end
  def popularity; end
  def popularity=(_arg0); end
  def poster_path; end
  def poster_path=(_arg0); end
  def production_companies; end
  def production_companies=(_arg0); end
  def production_countries; end
  def production_countries=(_arg0); end
  def release_date; end
  def release_date=(_arg0); end
  def releases; end
  def releases=(_arg0); end
  def revenue; end
  def revenue=(_arg0); end
  def reviews; end
  def reviews=(_arg0); end
  def runtime; end
  def runtime=(_arg0); end
  def spoken_languages; end
  def spoken_languages=(_arg0); end
  def status; end
  def status=(_arg0); end
  def tagline; end
  def tagline=(_arg0); end
  def title; end
  def title=(_arg0); end
  def trailers; end
  def trailers=(_arg0); end
  def translations; end
  def translations=(_arg0); end
  def vote_average; end
  def vote_average=(_arg0); end
  def vote_count; end
  def vote_count=(_arg0); end

  class << self
    # Get the alternative titles for a specific movie id.
    def alternative_titles(id, _conditions = T.unsafe(nil)); end

    # Get the cast information for a specific movie id.
    def casts(id, _conditions = T.unsafe(nil)); end

    # Get the changes for a specific movie id.
    # Changes are grouped by key, and ordered by date in descending order.
    # By default, only the last 24 hours of changes are returned.
    # The maximum number of days that can be returned in a single request is 14.
    # The language is present on fields that are translatable.
    def changes(id, _conditions = T.unsafe(nil)); end

    # Get the credits for a specific movie id.
    def credits(id, _conditions = T.unsafe(nil)); end

    # Get the cast information for a specific movie id.
    def crew(id, _conditions = T.unsafe(nil)); end

    # Discover movies by different types of data like average rating, number of votes, genres and certifications.
    def discover(conditions = T.unsafe(nil)); end

    # Get the images (posters and backdrops) for a specific movie id.
    def images(id, _conditions = T.unsafe(nil)); end

    # Get the plot keywords for a specific movie id.
    def keywords(id, _conditions = T.unsafe(nil)); end

    # Get the latest movie id. singular
    def latest; end

    # Get the lists that the movie belongs to.
    def lists(id, _conditions = T.unsafe(nil)); end

    # Get the list of movies playing in theatres. This list refreshes every day. The maximum number of items this list will include is 100.
    def now_playing; end

    # Get the list of popular movies on The Movie Database. This list refreshes every day.
    def popular; end

    # Get the release date by country for a specific movie id.
    def releases(id, _conditions = T.unsafe(nil)); end

    # Get the similar movies for a specific movie id.
    def similar_movies(id, conditions = T.unsafe(nil)); end

    # Get the list of top rated movies. By default, this list will only include movies that have 10 or more votes. This list refreshes every day.
    def top_rated; end

    # Get the trailers for a specific movie id.
    def trailers(id, _conditions = T.unsafe(nil)); end

    # Get the translations for a specific movie id.
    def translations(id, _conditions = T.unsafe(nil)); end

    # Get the list of upcoming movies. This list refreshes every day. The maximum number of items this list will include is 100.
    def upcoming; end
  end
end

class Tmdb::Person < ::Tmdb::Resource
  def adult; end
  def adult=(_arg0); end
  def also_known_as; end
  def also_known_as=(_arg0); end
  def biography; end
  def biography=(_arg0); end
  def birthday; end
  def birthday=(_arg0); end
  def changes; end
  def changes=(_arg0); end
  def combined_credits; end
  def combined_credits=(_arg0); end
  def deathday; end
  def deathday=(_arg0); end
  def homepage; end
  def homepage=(_arg0); end
  def id; end
  def id=(_arg0); end
  def images; end
  def images=(_arg0); end
  def known_for; end
  def known_for=(_arg0); end
  def movie_credits; end
  def movie_credits=(_arg0); end
  def name; end
  def name=(_arg0); end
  def place_of_birth; end
  def place_of_birth=(_arg0); end
  def profile_path; end
  def profile_path=(_arg0); end
  def tv_credits; end
  def tv_credits=(_arg0); end

  class << self
    # Get the changes for a specific person id.
    # Changes are grouped by key, and ordered by date in descending order.
    # By default, only the last 24 hours of changes are returned.
    # The maximum number of days that can be returned in a single request is 14. The language is present on fields that are translatable.
    def changes(id, _conditions = T.unsafe(nil)); end

    # Get the combined credits for a specific person id.
    def credits(id, _conditions = T.unsafe(nil)); end

    # Get external ID's for a specific person id.
    def external_ids(id, _conditions = T.unsafe(nil)); end

    # Get the images for a specific person id.
    def images(id, _conditions = T.unsafe(nil)); end

    # Get the latest person id.
    def latest; end

    # Get film credits for a specific person id.
    def movie_credits(id, _conditions = T.unsafe(nil)); end

    # Get the list of popular people on The Movie Database. This list refreshes every day.
    def popular; end

    # Get the tagged images for a specific person id.
    def tagged_images(id, _conditions = T.unsafe(nil)); end

    # Get TV credits for a specific person id.
    def tv_credits(id, _conditions = T.unsafe(nil)); end
  end
end

class Tmdb::Resource
  # @return [Resource] a new instance of Resource
  def initialize(attributes = T.unsafe(nil)); end

  class << self
    # Get the basic resource information for a specific id.
    def detail(id, conditions = T.unsafe(nil)); end

    def endpoint_id; end
    def endpoints; end
    def find(query); end
    def has_resource(singular = T.unsafe(nil), opts = T.unsafe(nil)); end
    def list(conditions = T.unsafe(nil)); end
    def search(query); end
  end
end

class Tmdb::Search
  # @return [Search] a new instance of Search
  def initialize(resource = T.unsafe(nil)); end

  # Sends back main data
  def fetch; end

  # Send back whole response
  def fetch_response(conditions = T.unsafe(nil)); end

  def filter(conditions); end
  def primary_release_year(year); end
  def query(query); end
  def resource(resource); end
  def year(year); end
end

class Tmdb::Season < ::Tmdb::Resource
  class << self
    # Get the cast credits for a TV season by season number.
    def cast(id, season, _conditions = T.unsafe(nil)); end

    # Get the crew credits for a TV season by season number.
    def crew(id, season, _conditions = T.unsafe(nil)); end

    # Get the primary information about a TV season by its season number.
    def detail(id, season, conditions = T.unsafe(nil)); end

    # Get the external ids that we have stored for a TV season by season number.
    def external_ids(id, season, _conditions = T.unsafe(nil)); end

    # Get the images (posters) that we have stored for a TV season by season number.
    def images(id, season, _conditions = T.unsafe(nil)); end
  end
end

class Tmdb::TV < ::Tmdb::Resource
  def backdrop_path; end
  def backdrop_path=(_arg0); end
  def created_by; end
  def created_by=(_arg0); end
  def credits; end
  def credits=(_arg0); end
  def episode_run_time; end
  def episode_run_time=(_arg0); end
  def external_ids; end
  def external_ids=(_arg0); end
  def first_air_date; end
  def first_air_date=(_arg0); end
  def genres; end
  def genres=(_arg0); end
  def homepage; end
  def homepage=(_arg0); end
  def id; end
  def id=(_arg0); end
  def in_production; end
  def in_production=(_arg0); end
  def languages; end
  def languages=(_arg0); end
  def last_air_date; end
  def last_air_date=(_arg0); end
  def name; end
  def name=(_arg0); end
  def networks; end
  def networks=(_arg0); end
  def number_of_episodes; end
  def number_of_episodes=(_arg0); end
  def number_of_seasons; end
  def number_of_seasons=(_arg0); end
  def origin_country; end
  def origin_country=(_arg0); end
  def original_name; end
  def original_name=(_arg0); end
  def overview; end
  def overview=(_arg0); end
  def popularity; end
  def popularity=(_arg0); end
  def poster_path; end
  def poster_path=(_arg0); end
  def seasons; end
  def seasons=(_arg0); end
  def status; end
  def status=(_arg0); end
  def vote_average; end
  def vote_average=(_arg0); end
  def vote_count; end
  def vote_count=(_arg0); end

  class << self
    # Get the cast information about a TV series.
    def cast(id, _conditions = T.unsafe(nil)); end

    # Get the crew information about a TV series.
    def crew(id, _conditions = T.unsafe(nil)); end

    # Discover TV shows by different types of data like average rating, number of votes, genres, the network they aired on and air dates
    def discover(conditions = T.unsafe(nil)); end

    # Get the external ids that we have stored for a TV series.
    def external_ids(id, _conditions = T.unsafe(nil)); end

    # Get the images (posters and backdrops) for a TV series.
    def images(id, _conditions = T.unsafe(nil)); end

    # Get the list of popular TV shows. This list refreshes every day.
    def popular; end

    # Get the list of top rated TV shows. By default, this list will only include TV shows that have 2 or more votes. This list refreshes every day.
    def top_rated; end
  end
end
