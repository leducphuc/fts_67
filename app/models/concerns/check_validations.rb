module CheckValidations extend ActiveSupport::Concern
  included do
    belongs_to :subject

    has_many :answers, as: :answerable, dependent: :destroy

    validates :content, presence: true
    validate :answers_size
    validate :check_correct_answer

    accepts_nested_attributes_for :answers, allow_destroy: true,
      reject_if: proc {|attributes| attributes[:content].blank?}

    private
    def answers_size
      errors.add :question, I18n.t("answer.size") if answers.size < 2
    end

    def check_correct_answer
      correct_answer = answers.select {|answer| answer.is_correct?}
      errors.add :correct_answer,
        I18n.t("answer.must_check") if correct_answer.empty?
    end
  end
end
