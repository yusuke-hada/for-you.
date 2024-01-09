document.addEventListener("DOMContentLoaded", function() {
    let imageSelect = document.getElementById('message_card_background_image');
    let imagePreview = document.getElementById('image_preview');
  
    imageSelect.addEventListener('change', function() {
      let selectedKey = this.value;
      let imageUrl = urls[selectedKey];
      
      if (imageUrl) {
        let imgTag = imagePreview.querySelector('img') || new Image();
        imgTag.src = imageUrl;
        imagePreview.innerHTML = '';
        imagePreview.appendChild(imgTag);
      }
    });
  });
  