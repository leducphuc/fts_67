class ActivityGenerator
  class << self
    def method_missing action, target_object
      byebug
      if action == :deleted
        activity = Activity.new
        activity.user_id = target_object.actor_id
        activity.action = action
        activity.activable_id = target_object.id
        activity.activable_type = target_object.class
        activity.save
      else
        activity =  target_object.activities.new
        activity.user_id = target_object.actor_id
        activity.save
      end
    end
  end
end
