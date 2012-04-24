require 'active_record'

class Utilisation < ActiveRecord::Base

  belongs_to :application # foreign key - application_id
  belongs_to :user # foreign key - user_id

  validates :user_id, :presence => true

  validates :application_id, :presence => true

  def self.present?(user, appli)
    
    if user.nil? || appli.nil?
      false
    else
      userid = user.id
      appliid = appli.id
      Utilisation.where(:user_id => userid, :application_id => appliid) != []
    end
  end


end
