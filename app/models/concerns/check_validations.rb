module CheckValidations extend ActiveSupport::Concern
  included do
    belongs_to :subject

    has_many :answers, as: :answerable, dependent: :destroy

    validates :content, presence: true
    validate :check_correct_answer
    validates :answers, length: {minimum: Settings.minimum_answer,
      message: I18n.t("answer.valid")}

    before_update :check_correct_answer

    accepts_nested_attributes_for :answers, allow_destroy: true,
      reject_if: proc {|attributes| attributes[:content].blank?}

    private
    def check_correct_answer
      correct_answer = answers.select {|answer| answer.is_correct?}
      errors.add :correct_answer,
        I18n.t("answer.must_check") if correct_answer.empty?
    end

    def generate_activity_for_create
    end

    def generate_activity_for_update
    end

    def generate_acitivty_for_destroy
      byebug
    end
  end
end
