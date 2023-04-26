class Ability
  include CanCan::Ability

  def initialize(user)

       user ||= User.new
       if user 
         if user.admin?
           can :manage, :all#, {author: user}
         else
           can :read, :all
           can :create, [Question, Answer, Comment]
           can :update, [Question, Answer, Comment], author: user
           can :destroy, Question, author: user
         end
      else
        can :read, :all
      end     
           
  end
end
