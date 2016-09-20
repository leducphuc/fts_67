class CreateSuggestAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :suggest_answers do |t|
      t.string :content
      t.boolean :is_correct, default: false
      t.references :suggest_question, foreign_key: true

      t.timestamps
    end
  end
end
