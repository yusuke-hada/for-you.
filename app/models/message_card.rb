class MessageCard < ApplicationRecord
  belongs_to :user
  validates :recipient_name, presence: true, length: { maximum: 20 }
  validates :message, presence: true, length: { maximum: 252 }
  validates :background_image, presence: true

  BACKGROUND_IMAGES = {
    'image1' => 'image1.webp',
    'image2' => 'image2.webp',
    'image3' => 'image3.webp',
    'image4' => 'image4.webp',
    'image5' => 'image5.webp'
  }.freeze

  def background_image_url
    key = BACKGROUND_IMAGES[background_image]
    generate_presigned_url(key)
  end

  def generate_image
    image = create_image_with_text
    print_image(image)
  end

  # HACK: Refactor this method to reduce ABC size and method length.
  def generate_image_with_text
    image = MiniMagick::Image.open(background_image_url)
    font_path = Rails.root.join('public', 'fonts', 'NotoSansJP-VariableFont_wght.ttf').to_s

    image.combine_options do |c|
      c.font font_path
      c.gravity 'center'
      c.pointsize 60
      c.stroke 'black'
      c.strokewidth 2
      c.draw "text 0,-310 '#{recipient_name}'"
      c.fill 'black'
    end

    message_lines = message.split("\n")
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
    ['user']
  end

  private

  def generate_presigned_url(key)
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    signer = Aws::S3::Presigner.new(client: s3.client)
    signer.presigned_url(:get_object, bucket: 'foryoustrage', key:, expires_in: 3600)
  end

  def create_image_with_text
    image = MiniMagick::Image.open(background_image_url)
    image.combine_options do |c|
      c.gravity 'center'
      c.draw "text 0,0 '#{recipient_name}'"
      c.draw "text 0,20 '#{message}'"
      c.pointsize 20
      c.fill 'black'
    end
    image
  end

  def print_image(image)
    image_path = Rails.root.join('public', 'images', "generated_#{id}.jpg")
    image.write(image_path)
    "/images/generated_#{id}.jpg"
  end
end
