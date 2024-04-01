# frozen_string_literal: true

module FinderMethods
  include Utils::DeepCompactable

  def find_by!(*args)
    call.reorder(nil).find_by!(*args)
  end

  def find_by(*args)
    call.reorder(nil).find_by(*args)
  end

  def find(*args)
    query_scope.find(*args)
  end

  def initialize!(args = {})
    query_scope.new(**args)
  end

  def sortings
    params[:sortings] || params["sortings"] || {}
  end

  def query_scope
    raise ArgumentError
  end

  def with_entry(collection, key)
    params.key?(key) ? yield : collection
  end

  def with_entries(collection, keys)
    keys.all? { |key| params.key?(key) } ? yield : collection
  end

  def with_any_entry(collection, keys)
    (key = keys.find { |key| params.key?(key) }) ? yield(key) : collection
  end
end
