document.addEventListener("DOMContentLoaded", function() {
    let form = document.querySelector("form");
    form.addEventListener("submit", function(event) {
      event.preventDefault();
      
      let formData = new FormData(form);
      fetch(form.action, {
        method: form.method,
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        if (data.message_card_id) {
          let image_url = `/users/${data.user_id}/message_cards/${data.message_card_id}/image`;
          window.open(image_url, '_blank');
          window.location.href = `/users/${data.user_id}/message_cards`;
        }
      })
      .catch(error => console.error('Error:', error));
    });
  });
  