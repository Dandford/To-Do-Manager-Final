
class Article < ApplicationRecord
attr_accessor :content, :name, :tag_list
has_many :taggings, dependent: :destroy 
has_many :tags, through: :taggings, dependent: :destroy 
accepts_nested_attributes_for :taggings, allow_destroy: true
 before_create :downcase_fields
 belongs_to :user    
 validates :user_id, presence: true
 validates :task, presence: true,
                   length: { minimum: 1}
 validates :deadline, presence: true,
                   length: { minimum: 1}      
def self.tagged_with(name)
  Tag.find_by_name!(name).articles
end


   def downcase_fields
      self.task.downcase
   end

def self.tag_counts
  Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
end

def tag_list
  tags.map(&:name).join(", ")
end

def tag_list=(names)
  self.tags = names.split(",").map do |n|
    Tag.where(name: n.strip).first_or_create!
  end
end

def self.search(term)
  if term
    where('title LIKE ?', "%#{term}%").order('id DESC')
  else
    order('id DESC') 
  end
end

end