class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :activable, polymorphic: true, optional: true

  enum action: [:created, :updated, :deleted]

  def description
    [action, created_at, user.name].join(" - ")
  end
end
