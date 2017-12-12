require 'open-uri'

class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  validates :filename, presence: true
  validates :mimetype, presence: true
  validates :base64, presence: true

  #def Image.properties_from_asset(asset)
  #  { filename: Pathname.new(asset.filename).basename, base64: Base64.strict_encode64(asset.to_s), mimetype: asset.content_type }
  #end

  def Image.properties_from_url(url)
    uri = URI.parse(url)
    contents = open(uri.to_s){ |f| f.read }
    { filename: Pathname.new(uri.path).basename, base64: Base64.strict_encode64(contents.to_s), mimetype: MIME::Types.type_for(uri.path).first.content_type }
  end

  def img_tag_src
    "data:#{mimetype};base64,#{base64}"
  end
end
