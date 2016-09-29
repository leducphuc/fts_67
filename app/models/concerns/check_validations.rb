module CheckValidations extend ActiveSupport::Concern
  included do
    belongs_to :subject

    has_many :answers, as: :answerable, dependent: :destroy

    validate :check_before_delete
    validates :content, presence: true
    validate :check_correct_answer
    validates :answers, length: {minimum: Settings.minimum_answer,
      message: I18n.t("answer.valid")}

    accepts_nested_attributes_for :answers, allow_destroy: true,
      reject_if: proc {|attributes| attributes[:content].blank?}

    private
    def check_correct_answer
      correct_answer = answers.select {|answer| answer.is_correct?}
      errors.add :correct_answer,
        I18n.t("answer.must_check") if correct_answer.empty?
    end

    def check_before_delete
      correct_answer = answers.select {|answer| answer.is_correct?}.size
      answers.each do |answer|
        if answer.is_correct? && answer.marked_for_destruction? &&
          correct_answer < 2
          errors.add :correct_answer, I18n.t("answer.must_check")
        end
      end
    end
  end
end
