# frozen_string_literal: true

require_relative "proptypes/version"

require "dry-types"
require "proptypes/constants"

module Proptypes
  class Error < StandardError; end

  include Dry.Types()
  include Constants

  StringOrNil = Coercible::String.optional
  IntegerOrNil = Coercible::Integer.optional
  BoolOrNil = Params::Bool.optional
  HashOrNil = Coercible::Hash.optional
  SymbolOrNil = Coercible::Symbol.optional

  HtmlTag = Coercible::Symbol.default(:div).enum(*HTML_TAGS).constructor do |value|
    value ||= :div
    value.to_sym
  end

  Option = (Interface(:call) | Any).constructor do |value|
    value.respond_to?(:call) ? value.call : value
  end

  EnumOption = Option.dup

  EnumOption.define_singleton_method(:enum) do |*values, &block|
    values = block ? block.call : values
    super(*values, nil)
  end

  Key = Coercible::Symbol.dup

  Key.define_singleton_method(:of) do |hash|
    enum(*hash.keys)
  end
end
