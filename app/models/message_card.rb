class MessageCard < ApplicationRecord
  belongs_to :user
  validates :recipient_name, presence: true, length: { maximum: 20 }
  validates :message, presence: true, length: { maximum: 252 }
  validates :background_image, presence: true

  BACKGROUND_IMAGES = {
    'image1' => 'F5E5D560-C7A8-4E94-AAB4-7BD794666BCE.PNG',
    'image2' => '2B12FFDC-630F-4EB2-959B-81DDD9070543.PNG',
    'image3' => '2163D970-995E-47DA-A45E-8E93F96187F1.PNG',
    'image4' => '3087C17B-FAF4-496E-A3A6-00FC74807949.PNG',
    'image5' => 'F822E977-4FEA-4BDA-BE77-0EEDB301FC2A.PNG',
  }.freeze 

  def background_image_url
    key = BACKGROUND_IMAGES[background_image]
    generate_presigned_url(key)
  end

  def generate_image
    image = MiniMagick::Image.open(self.background_image_url)
    image.combine_options do |c|
      c.gravity "center"
      c.draw "text 0,0 '#{self.recipient_name}'"
      c.draw "text 0,20 '#{self.message}'"
      c.pointsize 20
      c.fill "black"
    end
    image_path = Rails.root.join('public', 'images', "generated_#{self.id}.jpg")
    image.write(image_path)
    "/images/generated_#{self.id}.jpg"
  end

  def generate_image_with_text
    image = MiniMagick::Image.open(self.background_image_url)
    font_path = Rails.root.join('public', 'fonts', 'NotoSansJP-VariableFont_wght.ttf').to_s
    
    image.combine_options do |c|
      c.font font_path
      c.gravity 'center'
      c.pointsize 60 
      c.stroke 'black'
      c.strokewidth 2
      c.draw "text 0,-310 '#{self.recipient_name}'"
      c.fill 'black'
    end

    message_lines = self.message.split("\n")
    start_offset_y = -200
    line_height = 70

    message_lines.each_with_index do |line, index|
      image.combine_options do |c|
        c.font font_path
        c.gravity 'center'
        c.pointsize 40
        c.stroke 'black'
        c.strokewidth 2
        c.draw "text 0,#{start_offset_y + (line_height * index)} '#{line}'"
        c.fill 'black'
      end
    end
    image.to_blob
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[recipient_name message]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["user"]
  end

  private

  def generate_presigned_url(key)
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    signer = Aws::S3::Presigner.new(client: s3.client)
    signer.presigned_url(:get_object, bucket: 'foryoustrage', key: key, expires_in: 3600)
  end
end
