class MessageCardsController < ApplicationController
  before_action :set_message_card, only: [:show,:edit,:update,:destroy]

  def index
    @message_cards = current_user.message_cards.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @message_card = MessageCard.new
    @background_images = MessageCard::BACKGROUND_IMAGES
    @background_images_urls = @background_images.transform_values do |key|
      generate_presigned_url(key)
    end
  end

  def create
    @message_card = current_user.message_cards.build(message_card_params)
    if @message_card.save
      redirect_to user_message_cards_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @message_card.errors.full_messages
      render :new
    end
  end

  def show ;end

  def edit ;end

  def update
    if @message_card.update(message_card_params)
      redirect_to user_message_cards_path(current_user), notice: t('.success')
    else
      flash.now[:alert] = @message_card.errors.full_messages
      render :edit
    end
  end

  def destroy
    @message_card.destroy!
    redirect_to user_message_cards_path, alert: t('.success'), status: :see_other
  end

  private

  def generate_presigned_url(key)
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    signer = Aws::S3::Presigner.new(client: s3.client)
    signer.presigned_url(:get_object, bucket: 'foryoustrage', key: key, expires_in: 3600)
  end

  def message_card_params
    params.require(:message_card).permit(:recipient_name, :message, :background_image)
  end

  def set_message_card
    @message_card = current_user.message_cards.find(params[:id])
  end
end