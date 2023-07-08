class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
       if user 
         user.admin? ? admin_abilities : user_abilities
      else
        guest_abilities
      end 
  end

  def guest_abilities
    can :read, :all   
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    user_base_abilites
    user_specific_abilites
  end

  def user_base_abilites
    guest_abilities
    can :my_answers, [Answer]
    can :create, [Question, Answer, Comment, Link, Subscription]
    can :update, [Question, Answer, Comment], author: user
    can :destroy, [Question, Answer, Comment], author: user
    can :destroy, Subscription, user: user
    can :destroy, Link, linkable: { author: user }
    can :vote, Answer, question: { author: user}
    can :like, Question 
    cannot :like, Question, author: user
    can :dislike, Question do |question|
      question.author != user
    end
  end

  def user_specific_abilites
    user_abilities_with_link
    user_abilities_with_attachement

  end

  def user_abilities_with_link
    can :destroy, Link do |link|
      user.author_of?(link.linkable)
    end 
  end
  
  def user_abilities_with_attachement
    can :destroy, ActiveStorage::Attachment do |file|
      user.author_of?(file.record)
    end
  end

end
