require 'octokit'

class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true 
  validates :url, format: URI::regexp

  def gist?
    self.url.include?('gist.github.com')  
  end

  def get_gist
    Octokit.gist_comment('208sdaz3', 1451398)    
  end

end
