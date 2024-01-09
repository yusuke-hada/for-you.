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

  private

  def generate_presigned_url(key)
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    signer = Aws::S3::Presigner.new(client: s3.client)
    signer.presigned_url(:get_object, bucket: 'foryoustrage', key: key, expires_in: 3600)
  end
end
