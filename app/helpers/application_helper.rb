module ApplicationHelper
  include Pagy::Frontend

  def gravatar_for(user, options = { size: 100, class: "gravatar" })
    return unless user.present? && user.email.present?

    email_hash = Digest::MD5.hexdigest(user.email.downcase.strip)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size}"

    image_tag(gravatar_url, alt: user.email, class: options[:class])
  end

  def full_title(page_title = '')
    base_title = "Blog Sample"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
