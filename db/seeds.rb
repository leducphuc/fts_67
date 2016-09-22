User.create name: "Example User", email: "admin@admin.com",
  password: "password",password_confirmation: "password", is_admin: true

40.times do |n|
  name = "user#{n}"
  email = "user#{n}@email.com"
  password = "password"
  User.create name: name, email: email, password: password
end

Subject.create name: "English",
  description:"This is description"

80.times do |n|
  question = Question.create content: "This is question #{n+1}",
    subject: Subject.find_by_id(1)
   5.times do |m|
     is_correct = true if (m+1)%5 == 0
     question.answers.create content: "This is answer #{(m+1)*(n+1)}",
       is_correct: is_correct
   end
end

15.times do |n|
  suggest_question = SuggestQuestion.create subject_id: 1,
    user_id: 1,
    content: "This is SuggestQuestion #{n}"
   5.times do |m|
     is_correct = true if (m+1)%5 == 0
     suggest_question.answers.create content: "This is suggest answer
     #{(m+1)*(n+1)}",
       is_correct: is_correct
   end
end
