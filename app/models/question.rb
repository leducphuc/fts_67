class Question < ApplicationRecord
  include CheckValidations

  attr_accessor :actor_id

  has_many :choices, dependent: :destroy
  has_many :activity, as: :activable, dependent: :destroy

  after_create {ActivityGenerator.created self}
  after_update {ActivityGenerator.updated self}
  after_destroy {ActivityGenerator.deleted self}

  class << self
    def search(params)
      if params
        where("content LIKE :content_part",
          {content_part: "%#{params[:content]}%"})
      else
        all
      end
    end
  end
end
