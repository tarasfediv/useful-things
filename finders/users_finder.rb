# frozen_string_literal: true

class UsersFinder
  include Utils::Contextable
  include Utils::Callable
  include FinderMethods

  attr_accessor :context, :params

  with_context :current_user

  def initialize(context, params = {})
    @context = context
    @params = deep_compact(params) || {}
  end

  def call
    collection = preload(query_scope)
    collection = by_type(collection)
    collection = by_active(collection)
    collection = by_search(collection)

    sort(collection)
  end

  private

  def preload(collection)
    with_entry(collection, :preloaders) do
      collection.preload(*params[:preloaders])
    end
  end

  def by_type(collection)
    with_entry(collection, :type) do
      collection.where(type: params[:type])
    end
  end

  def by_active(collection)
    with_entry(collection, :active) do
      collection.where(active: params[:active])
    end
  end

  def by_search(collection)
    with_entry(collection, :search) do
      collection.search(params[:search])
    end
  end

  def sort(collection)
    return collection if sortings.blank?

    collection.order(sortings)
  end

  def query_scope
    Pundit.policy_scope(current_user, User)
  end
end

