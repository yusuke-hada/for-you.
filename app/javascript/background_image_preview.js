// background_image_preview.js
document.addEventListener("DOMContentLoaded", function() {
    let imageSelect = document.getElementById('message_card_background_image');
    let recipientNameInput = document.getElementById('message_card_recipient_name');
    let messageInput = document.getElementById('message_card_message');
    let imageContainer = document.getElementById('image_container'); // 画像のみを含むコンテナ
    let recipientNamePreview = document.getElementById('preview-recipient-name');
    let messagePreview = document.getElementById('preview-message');
    let currentImageUrl = ''; // 現在選択されている画像URLを追跡する
  
    function updateTextPreview() {
        if (currentImageUrl) { // 画像が選択されているかチェック
          recipientNamePreview.textContent = recipientNameInput.value;
          // 改行を <br> タグに置換する
          messagePreview.innerHTML = messageInput.value.replace(/\n/g, '<br>');
        }
    }

    function updateInitialPreview() {
        let selectedKey = imageSelect.value;
        currentImageUrl = urls[selectedKey];
        
        if (currentImageUrl) {
            let imgTag = new Image();
            imgTag.src = currentImageUrl;
            imageContainer.innerHTML = '';
            imageContainer.appendChild(imgTag);
        }

        updateTextPreview();
    }

    // 初期プレビューを設定
    updateInitialPreview();
  
    imageSelect.addEventListener('change', function() {
      let selectedKey = this.value;
      currentImageUrl = urls[selectedKey]; // 修正: 正しく現在の画像URLを更新する
  
      if (currentImageUrl) {
        let imgTag = imageContainer.querySelector('img') || new Image();
        imgTag.src = currentImageUrl;
        imageContainer.innerHTML = ''; // 画像コンテナのみをクリアする
        imageContainer.appendChild(imgTag);
        updateTextPreview();
      } else {
        imageContainer.innerHTML = '';
        recipientNamePreview.textContent = '';
        messagePreview.textContent = '';
      }
    });

    // Update text preview when the text inputs change
    recipientNameInput.addEventListener('input', updateTextPreview);
    messageInput.addEventListener('input', updateTextPreview);
  });