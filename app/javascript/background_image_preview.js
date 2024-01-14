document.addEventListener("DOMContentLoaded", function() {
    let imageSelect = document.getElementById('message_card_background_image');
    let recipientNameInput = document.getElementById('message_card_recipient_name');
    let messageInput = document.getElementById('message_card_message');
    let imageContainer = document.getElementById('image_container');
    let recipientNamePreview = document.getElementById('preview-recipient-name');
    let messagePreview = document.getElementById('preview-message');
    let currentImageUrl = '';
  
    function updateTextPreview() {
        if (currentImageUrl) {
          recipientNamePreview.textContent = recipientNameInput.value;
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

    updateInitialPreview();
  
    imageSelect.addEventListener('change', function() {
      let selectedKey = this.value;
      currentImageUrl = urls[selectedKey];
  
      if (currentImageUrl) {
        let imgTag = imageContainer.querySelector('img') || new Image();
        imgTag.src = currentImageUrl;
        imageContainer.innerHTML = '';
        imageContainer.appendChild(imgTag);
        updateTextPreview();
      } else {
        imageContainer.innerHTML = '';
        recipientNamePreview.textContent = '';
        messagePreview.textContent = '';
      }
    });

    recipientNameInput.addEventListener('input', updateTextPreview);
    messageInput.addEventListener('input', updateTextPreview);
  });