$: << File.dirname(__FILE__)
require 'active_record'
require 'utilisation'

class Application < ActiveRecord::Base

  has_many :utilisations
  has_many :user, :through => :utilisations

  validates :name, :presence => true
  validates :name, :uniqueness => true
  validates :name, :format => { :with => /^[a-z0-9_-]{2,}$/i, :on => :create }

  validates :url, :presence => true
  validates :url, :format => { :with => /^http:\/\/[a-z0-9._\/-:]/i, :on => :create }

  validates :user_id, :presence => true


   def self.delete(appli)

        uti = Utilisation.where(:application_id => appli.id)

        if uti != nil
          uti.each do |u|
            u.destroy
          end
        end

        appli.destroy
   end

  def self.present?(name)
    a = Application.find_by_name(name)
    !a.nil?
  end

end
