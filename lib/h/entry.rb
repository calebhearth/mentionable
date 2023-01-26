class H::Entry < H::Base
  def self.attributes # :nodoc:
    [
      :name,
      :summary,
      :content,
      :published,
      :updated,
      :author,
      :categories,
      :url,
      :uid,
      :location,
      :syndications,
      :in_reply_to,
      :rsvp,
      :like_of,
      :repost_of,
      :comments,
      :photos,
      :videos,
      :audios,
      :likes,
      :reposts,
      :bookmark_of,
      :featured,
      :duration,
      :size,
      :listen_of,
      :watch_of,
      :read_of,
      :translation_of,
      :checkin,
      :children,
    ]
  end

  def self.plural_attributes
    %i[categories syndications comments photos videos audios likes reposts in_reply_to]
  end

  def self.date_attributes = %i[published updated]
  def self.special_attributes = %i[content]

  attributes.each { attr_accessor _1 }

  def initialize(properties:, children: nil)
    super
    @content = properties[:content]
  end
end
