class Post < ActiveRecord::Base
  has_many :comments, :dependent => :delete_all

 def self.exist?(id)
   Post.find_by_id(id) != nil
 end

end
