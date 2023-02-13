require 'octokit'

class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true 
  validates :url, format: URI::regexp

  def gist?
    self.url.include?('gist.github.com')  
  end

end
