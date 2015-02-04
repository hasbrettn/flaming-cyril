require 'json'

# Notification.rb
#
class Notification < ActiveRecord::Base

  validates :title, presence: true
  validates :message, presence: true
  validates :image_url, presence: true
  validates :email_address, presence: true

  def to_hash
    return {
        'title' => self.title,
        'message' => self.message,
        'image_url' => self.image_url,
        'email_address' => self.email_address
    }
  end

  def self.from_hash(hash)
    notification = Notification.new
    notification.title = hash['title']
    notification.message = hash['message']
    notification.image_url = hash['image_url']
    notification.email_address = hash['email_address']
    return notification
  end

  def to_json
    return to_hash.to_json
  end

  def self.from_json(json)
    hash = JSON.parse(json)
    return Notification.from_hash(hash)
  end

  def ==(other)
    return other.title == self.title &&
        other.message == self.message &&
        other.image_url == self.image_url &&
        other.email_address == self.email_address
  end

end