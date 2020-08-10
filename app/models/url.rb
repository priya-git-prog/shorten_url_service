class Url < ApplicationRecord

  UNIQUE_ID = 5
  validates :long_url, presence: true, on: :create
  before_create :generate_short_url, :sanitize

  def generate_short_url
    url = ([*('a'..'z'),*('0'..'9')]).sample(UNIQUE_ID).join
    old_url = Url.where(short_url: url).last
    if old_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end

  def find_duplicate
    Url.find_by(sanitize_url: self.sanitize_url)
  end

  def new_url?
    find_duplicate.nil?
  end

  def sanitize
    self.long_url.strip!
    self.sanitize_url = self.long_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    self.sanitize_url = "http://#{self.sanitize_url}"
  end
end
