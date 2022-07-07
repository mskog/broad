# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `http-form_data` gem.
# Please instead update this file by running `bin/tapioca gem http-form_data`.

# http gem namespace.
#
# @see https://github.com/httprb/http
module HTTP
  class << self
    # HTTP[:accept => 'text/html'].get(...)
    def [](headers); end
  end
end

# Utility-belt to build form data request bodies.
# Provides support for `application/x-www-form-urlencoded` and
# `multipart/form-data` types.
#
# @example Usage
#
#   form = FormData.create({
#   :username     => "ixti",
#   :avatar_file  => FormData::File.new("/home/ixti/avatar.png")
#   })
#
#   # Assuming socket is an open socket to some HTTP server
#   socket << "POST /some-url HTTP/1.1\r\n"
#   socket << "Host: example.com\r\n"
#   socket << "Content-Type: #{form.content_type}\r\n"
#   socket << "Content-Length: #{form.content_length}\r\n"
#   socket << "\r\n"
#   socket << form.to_s
module HTTP::FormData
  class << self
    # FormData factory. Automatically selects best type depending on given
    # `data` Hash.
    #
    # @param data [#to_h, Hash]
    # @return [Multipart] if any of values is a {FormData::File}
    # @return [Urlencoded] otherwise
    def create(data, encoder: T.unsafe(nil)); end

    # Coerce `obj` to Hash.
    #
    # @note Internal usage helper, to workaround lack of `#to_h` on Ruby < 2.1
    # @raise [Error] `obj` can't be coerced.
    # @return [Hash]
    def ensure_hash(obj); end

    private

    # Tells whenever data contains multipart data or not.
    #
    # @param data [Hash]
    # @return [Boolean]
    def multipart?(data); end
  end
end

# CRLF
HTTP::FormData::CRLF = T.let(T.unsafe(nil), String)

# Provides IO interface across multiple IO objects.
class HTTP::FormData::CompositeIO
  # @param ios [Array<IO>] Array of IO objects
  # @return [CompositeIO] a new instance of CompositeIO
  def initialize(ios); end

  # Reads and returns partial content acrosss multiple IO objects.
  #
  # @param length [Integer] Number of bytes to retrieve
  # @param outbuf [String] String to be replaced with retrieved data
  # @return [String, nil]
  def read(length = T.unsafe(nil), outbuf = T.unsafe(nil)); end

  # Rewinds all IO objects and set cursor to the first IO object.
  def rewind; end

  # Returns sum of all IO sizes.
  def size; end

  private

  # Advances cursor to the next IO object.
  def advance_io; end

  # Returns IO object under the cursor.
  def current_io; end

  # Yields chunks with total length up to `length`.
  def read_chunks(length = T.unsafe(nil)); end

  # Reads chunk from current IO with length up to `max_length`.
  def readpartial(max_length = T.unsafe(nil)); end
end

# Generic FormData error.
class HTTP::FormData::Error < ::StandardError; end

# Represents file form param.
#
# @example Usage with StringIO
#
#   io = StringIO.new "foo bar baz"
#   FormData::File.new io, :filename => "foobar.txt"
# @example Usage with IO
#
#   File.open "/home/ixti/avatar.png" do |io|
#   FormData::File.new io
#   end
# @example Usage with pathname
#
#   FormData::File.new "/home/ixti/avatar.png"
class HTTP::FormData::File < ::HTTP::FormData::Part
  # @option opts
  # @option opts
  # @param path_or_io [String, Pathname, IO] Filename or IO instance.
  # @param opts [#to_h]
  # @return [File] a new instance of File
  # @see DEFAULT_MIME
  def initialize(path_or_io, opts = T.unsafe(nil)); end

  # @deprecated Use #content_type instead
  def mime_type; end

  private

  def filename_for(io); end
  def make_io(path_or_io); end
end

# Default MIME type
HTTP::FormData::File::DEFAULT_MIME = T.let(T.unsafe(nil), String)

# `multipart/form-data` form data.
class HTTP::FormData::Multipart
  include ::HTTP::FormData::Readable

  # @param data [#to_h, Hash] form data key-value Hash
  # @return [Multipart] a new instance of Multipart
  def initialize(data, boundary: T.unsafe(nil)); end

  # Returns the value of attribute boundary.
  def boundary; end

  # Returns form data content size to be used for HTTP request
  # `Content-Length` header.
  #
  # @return [Integer]
  def content_length; end

  # Returns MIME type to be used for HTTP request `Content-Type` header.
  #
  # @return [String]
  def content_type; end

  private

  # @return [String]
  def glue; end

  # @return [String]
  def tail; end

  class << self
    # Generates a string suitable for using as a boundary in multipart form
    # data.
    #
    # @return [String]
    def generate_boundary; end
  end
end

# Utility class to represent multi-part chunks
class HTTP::FormData::Multipart::Param
  include ::HTTP::FormData::Readable

  # Initializes body part with headers and data.
  #
  # @example With {FormData::File} value
  #
  #   Content-Disposition: form-data; name="avatar"; filename="avatar.png"
  #   Content-Type: application/octet-stream
  #
  #   ...data of avatar.png...
  # @example With non-{FormData::File} value
  #
  #   Content-Disposition: form-data; name="username"
  #
  #   ixti
  # @param name [#to_s]
  # @param value [FormData::File, FormData::Part, #to_s]
  # @return [String]
  def initialize(name, value); end

  private

  def content_type; end
  def filename; end
  def footer; end
  def header; end
  def parameters; end

  class << self
    # Flattens given `data` Hash into an array of `Param`'s.
    # Nested array are unwinded.
    # Behavior is similar to `URL.encode_www_form`.
    #
    # @param data [Hash]
    # @return [Array<FormData::MultiPart::Param>]
    def coerce(data); end
  end
end

# Represents a body part of multipart/form-data request.
#
# @example Usage with String
#
#   body = "Message"
#   FormData::Part.new body, :content_type => 'foobar.txt; charset="UTF-8"'
class HTTP::FormData::Part
  include ::HTTP::FormData::Readable

  # @param body [#to_s]
  # @param content_type [String] Value of Content-Type header
  # @param filename [String] Value of filename parameter
  # @return [Part] a new instance of Part
  def initialize(body, content_type: T.unsafe(nil), filename: T.unsafe(nil)); end

  # Returns the value of attribute content_type.
  def content_type; end

  # Returns the value of attribute filename.
  def filename; end
end

# Common behaviour for objects defined by an IO object.
module HTTP::FormData::Readable
  # Reads and returns part of IO content.
  #
  # @param length [Integer] Number of bytes to retrieve
  # @param outbuf [String] String to be replaced with retrieved data
  # @return [String, nil]
  def read(length = T.unsafe(nil), outbuf = T.unsafe(nil)); end

  # Rewinds the IO.
  def rewind; end

  # Returns IO size.
  #
  # @return [Integer]
  def size; end

  # Returns IO content.
  #
  # @return [String]
  def to_s; end
end

# `application/x-www-form-urlencoded` form data.
class HTTP::FormData::Urlencoded
  include ::HTTP::FormData::Readable

  # @param data [#to_h, Hash] form data key-value Hash
  # @return [Urlencoded] a new instance of Urlencoded
  def initialize(data, encoder: T.unsafe(nil)); end

  # Returns form data content size to be used for HTTP request
  # `Content-Length` header.
  #
  # @return [Integer]
  def content_length; end

  # Returns MIME type to be used for HTTP request `Content-Type` header.
  #
  # @return [String]
  def content_type; end

  class << self
    # Returns form data encoder implementation.
    # Default: `URI.encode_www_form`.
    #
    # @return [#call]
    # @see .encoder=
    def encoder; end

    # Set custom form data encoder implementation.
    #
    # @example
    #
    #   module CustomFormDataEncoder
    #   UNESCAPED_CHARS = /[^a-z0-9\-\.\_\~]/i
    #
    #   def self.escape(s)
    #   ::URI::DEFAULT_PARSER.escape(s.to_s, UNESCAPED_CHARS)
    #   end
    #
    #   def self.call(data)
    #   parts = []
    #
    #   data.each do |k, v|
    #   k = escape(k)
    #
    #   if v.nil?
    #   parts << k
    #   elsif v.respond_to?(:to_ary)
    #   v.to_ary.each { |vv| parts << "#{k}=#{escape vv}" }
    #   else
    #   parts << "#{k}=#{escape v}"
    #   end
    #   end
    #
    #   parts.join("&")
    #   end
    #   end
    #
    #   HTTP::FormData::Urlencoded.encoder = CustomFormDataEncoder
    # @param implementation [#call]
    # @raise [ArgumentError] if implementation deos not responds to `#call`.
    # @return [void]
    def encoder=(implementation); end
  end
end

# Gem version.
HTTP::FormData::VERSION = T.let(T.unsafe(nil), String)

HTTP::VERSION = T.let(T.unsafe(nil), String)
