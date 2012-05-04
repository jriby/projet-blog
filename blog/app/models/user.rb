class User

 def self.find(session)
   session["current_user_blog"]
 end

end
