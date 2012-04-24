$: << File.dirname(__FILE__)
require 'active_record'
require 'digest/sha1'
require 'application'
require 'utilisation'

class User < ActiveRecord::Base

  has_many :utilisations
  has_many :applications, :through => :utilisations

  validates :login, :presence => true
  validates :login, :uniqueness => true
  validates :passwd, :presence => true
   
  def passwd=(passwd)
    if !passwd.nil? && !passwd.empty?
    self[:passwd] = User.encrypt_password(passwd)
    else
    self[:passwd] = nil
  end
end

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest(password).inspect
  end

  def self.present?(login, password)
    u = User.find_by_login(login)
    !u.nil? && u.passwd == User.encrypt_password(password)
  end

   def self.delete(usr)
  
   app = Application.where(:user_id => usr.id)
   
     if app != nil
       app.each do |a|
         Application.delete(a)
       end
     end

   usr.destroy

  end

end

