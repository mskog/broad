# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `hashdiff` gem.
# Please instead update this file by running `bin/tapioca gem hashdiff`.

# This module provides methods to diff two hash, patch and unpatch hash
module Hashdiff
  class << self
    # Best diff two objects, which tries to generate the smallest change set using different similarity values.
    #
    # Hashdiff.best_diff is useful in case of comparing two objects which include similar hashes in arrays.
    #
    # @example
    #   a = {'x' => [{'a' => 1, 'c' => 3, 'e' => 5}, {'y' => 3}]}
    #   b = {'x' => [{'a' => 1, 'b' => 2, 'e' => 5}] }
    #   diff = Hashdiff.best_diff(a, b)
    #   diff.should == [['-', 'x[0].c', 3], ['+', 'x[0].b', 2], ['-', 'x[1].y', 3], ['-', 'x[1]', {}]]
    # @param obj1 [Array, Hash]
    # @param obj2 [Array, Hash]
    # @param options [Hash] the options to use when comparing
    #   * :strict (Boolean) [true] whether numeric values will be compared on type as well as value.  Set to false to allow comparing Integer, Float, BigDecimal to each other
    #   * :indifferent (Boolean) [false] whether to treat hash keys indifferently.  Set to true to ignore differences between symbol keys (ie. {a: 1} ~= {'a' => 1})
    #   * :delimiter (String) ['.'] the delimiter used when returning nested key references
    #   * :numeric_tolerance (Numeric) [0] should be a positive numeric value.  Value by which numeric differences must be greater than.  By default, numeric values are compared exactly; with the :tolerance option, the difference between numeric values must be greater than the given value.
    #   * :strip (Boolean) [false] whether or not to call #strip on strings before comparing
    #   * :array_path (Boolean) [false] whether to return the path references for nested values in an array, can be used for patch compatibility with non string keys.
    #   * :use_lcs (Boolean) [true] whether or not to use an implementation of the Longest common subsequence algorithm for comparing arrays, produces better diffs but is slower.
    # @return [Array] an array of changes.
    #   e.g. [[ '+', 'a.b', '45' ], [ '-', 'a.c', '5' ], [ '~', 'a.x', '45', '63']]
    # @since 0.0.1
    # @yield [path, value1, value2] Optional block is used to compare each value, instead of default #==. If the block returns value other than true of false, then other specified comparison options will be used to do the comparison.
    def best_diff(obj1, obj2, options = T.unsafe(nil), &block); end

    # check if objects are comparable
    #
    # @private
    # @return [Boolean]
    def comparable?(obj1, obj2, strict = T.unsafe(nil)); end

    # check for equality or "closeness" within given tolerance
    #
    # @private
    def compare_values(obj1, obj2, options = T.unsafe(nil)); end

    # count node differences
    #
    # @private
    def count_diff(diffs); end

    # count total nodes for an object
    #
    # @private
    def count_nodes(obj); end

    # try custom comparison
    #
    # @private
    def custom_compare(method, key, obj1, obj2); end

    # decode property path into an array
    # e.g. "a.b[3].c" => ['a', 'b', 3, 'c']
    #
    # @param path [String] Property-string
    # @param delimiter [String] Property-string delimiter
    # @private
    def decode_property_path(path, delimiter = T.unsafe(nil)); end

    # Compute the diff of two hashes or arrays
    #
    # @example
    #   a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    #   b = {"a" => 1, "b" => {}}
    #
    #   diff = Hashdiff.diff(a, b)
    #   diff.should == [['-', 'b.b1', 1], ['-', 'b.b2', 2]]
    # @param obj1 [Array, Hash]
    # @param obj2 [Array, Hash]
    # @param options [Hash] the options to use when comparing
    #   * :strict (Boolean) [true] whether numeric values will be compared on type as well as value.  Set to false to allow comparing Integer, Float, BigDecimal to each other
    #   * :indifferent (Boolean) [false] whether to treat hash keys indifferently.  Set to true to ignore differences between symbol keys (ie. {a: 1} ~= {'a' => 1})
    #   * :similarity (Numeric) [0.8] should be between (0, 1]. Meaningful if there are similar hashes in arrays. See {best_diff}.
    #   * :delimiter (String) ['.'] the delimiter used when returning nested key references
    #   * :numeric_tolerance (Numeric) [0] should be a positive numeric value.  Value by which numeric differences must be greater than.  By default, numeric values are compared exactly; with the :tolerance option, the difference between numeric values must be greater than the given value.
    #   * :strip (Boolean) [false] whether or not to call #strip on strings before comparing
    #   * :array_path (Boolean) [false] whether to return the path references for nested values in an array, can be used for patch compatibility with non string keys.
    #   * :use_lcs (Boolean) [true] whether or not to use an implementation of the Longest common subsequence algorithm for comparing arrays, produces better diffs but is slower.
    # @return [Array] an array of changes.
    #   e.g. [[ '+', 'a.b', '45' ], [ '-', 'a.c', '5' ], [ '~', 'a.x', '45', '63']]
    # @since 0.0.1
    # @yield [path, value1, value2] Optional block is used to compare each value, instead of default #==. If the block returns value other than true of false, then other specified comparison options will be used to do the comparison.
    def diff(obj1, obj2, options = T.unsafe(nil), &block); end

    # diff array using LCS algorithm
    #
    # @private
    # @yield [links]
    def diff_array_lcs(arraya, arrayb, options = T.unsafe(nil)); end

    # caculate array difference using LCS algorithm
    # http://en.wikipedia.org/wiki/Longest_common_subsequence_problem
    #
    # @private
    def lcs(arraya, arrayb, options = T.unsafe(nil)); end

    # get the node of hash by given path parts
    #
    # @private
    def node(hash, parts); end

    # Apply patch to object
    #
    # @param obj [Hash, Array] the object to be patched, can be an Array or a Hash
    # @param changes [Array] e.g. [[ '+', 'a.b', '45' ], [ '-', 'a.c', '5' ], [ '~', 'a.x', '45', '63']]
    # @param options [Hash] supports following keys:
    #   * :delimiter (String) ['.'] delimiter string for representing nested keys in changes array
    # @return the object after patch
    # @since 0.0.1
    def patch!(obj, changes, options = T.unsafe(nil)); end

    def prefix_append_array_index(prefix, array_index, opts); end
    def prefix_append_key(prefix, key, opts); end

    # judge whether two objects are similar
    #
    # @private
    # @return [Boolean]
    def similar?(obja, objb, options = T.unsafe(nil)); end

    # Unpatch an object
    #
    # @param obj [Hash, Array] the object to be unpatched, can be an Array or a Hash
    # @param changes [Array] e.g. [[ '+', 'a.b', '45' ], [ '-', 'a.c', '5' ], [ '~', 'a.x', '45', '63']]
    # @param options [Hash] supports following keys:
    #   * :delimiter (String) ['.'] delimiter string for representing nested keys in changes array
    # @return the object after unpatch
    # @since 0.0.1
    def unpatch!(obj, changes, options = T.unsafe(nil)); end

    private

    # checks if both objects are Arrays or Hashes
    #
    # @private
    # @return [Boolean]
    def any_hash_or_array?(obja, objb); end
  end
end

# Used to compare hashes
#
# @private
class Hashdiff::CompareHashes
  class << self
    def call(obj1, obj2, opts = T.unsafe(nil)); end
  end
end

# Used to compare arrays using the lcs algorithm
#
# @private
class Hashdiff::LcsCompareArrays
  class << self
    def call(obj1, obj2, opts = T.unsafe(nil)); end
  end
end

# Used to compare arrays in a linear complexity, which produces longer diffs
# than using the lcs algorithm but is considerably faster
#
# @private
class Hashdiff::LinearCompareArray
  # @return [LinearCompareArray] a new instance of LinearCompareArray
  def initialize(old_array, new_array, options); end

  def call; end

  private

  # Returns the value of attribute additions.
  def additions; end

  def append_addition(item, index); end
  def append_addititions_before_match(match_index); end
  def append_deletion(item, index); end
  def append_deletions_before_match(match_index); end
  def append_differences(difference); end
  def changes; end
  def compare_at_index; end

  # Returns the value of attribute deletions.
  def deletions; end

  # Returns the value of attribute differences.
  def differences; end

  # Returns the value of attribute expected_additions.
  def expected_additions; end

  # Sets the attribute expected_additions
  #
  # @param value the value to set the attribute expected_additions to.
  def expected_additions=(_arg0); end

  # @return [Boolean]
  def extra_items_in_new_array?; end

  # @return [Boolean]
  def extra_items_in_old_array?; end

  # look ahead in the new array to see if the current item appears later
  # thereby having new items added
  def index_of_match_after_additions; end

  # look ahead in the old array to see if the current item appears later
  # thereby having items removed
  def index_of_match_after_deletions; end

  def item_difference(old_item, new_item, item_index); end

  # @return [Boolean]
  def iterated_through_both_arrays?; end

  # Returns the value of attribute new_array.
  def new_array; end

  # Returns the value of attribute new_index.
  def new_index; end

  # Sets the attribute new_index
  #
  # @param value the value to set the attribute new_index to.
  def new_index=(_arg0); end

  # Returns the value of attribute old_array.
  def old_array; end

  # Returns the value of attribute old_index.
  def old_index; end

  # Sets the attribute old_index
  #
  # @param value the value to set the attribute old_index to.
  def old_index=(_arg0); end

  # Returns the value of attribute options.
  def options; end

  class << self
    def call(old_array, new_array, options = T.unsafe(nil)); end
  end
end

Hashdiff::VERSION = T.let(T.unsafe(nil), String)
