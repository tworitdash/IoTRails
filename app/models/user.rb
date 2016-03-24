class User < ActiveRecord::Base
	has_many :tweets
	require 'digest/sha1'
	attr_accessor :password

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
	#regular validation
	#validates_presence_of :full_name
	#validates_length_of :full_name, :maximum => 50
	#validates_presence_of :username
	#validates_length_of :username, :within => 8..50
	#validates_uniqueness_of :username
	#validates_presence_of :email
	#validates_length_of :email, :maximum => 100
	#validates_format_of :email, :with => EMAIL_REGEX 
	#validates_confirmation_of :email

	#sexy validation
	validates :full_name, :presence => true, :length => {:maximum => 50}
	validates :username, :length => {:within => 8..25}, :uniqueness => true
	validates :email, :presence => true, :length => {:maximum => 100}, :format => EMAIL_REGEX, :confirmation => true
	#validates_length_of :password, :within => 8..25, :on => :create
	validates :password, :presence => true, :length => {:within => 8..25, :on => :create}, :confirmation => true

	before_save :create_hashed_password
	after_save :clear_password
	attr_protected :hashed_password, :salt

	def self.authenticate(username="", password="")
		user = User.find_by_username(username)
		if user && user.password_match?(password)
			return user
		else 
			return false
		end
	end

	def password_match?(password="")
		hashed_password == User.hash_with_salt(password, salt)
	end
	def self.make_salt(username="")
		Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt" )
	end
	def self.hash_with_salt(password="", salt="")
		Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
	end
private
	def create_hashed_password
		unless password.blank?
			self.salt = User.make_salt(username) if salt.blank?
			self.hashed_password = User.hash_with_salt(password, salt)
		end
	end
	def clear_password
		self.password = nil
	end 

end

