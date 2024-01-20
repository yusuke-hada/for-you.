document.addEventListener("DOMContentLoaded", function() {
    let form = document.querySelector("form");
    form.addEventListener("submit", function(event) {
      event.preventDefault();
      
      let formData = new FormData(form);
      fetch(form.action, {
        method: form.method,
        body: formData
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('ネットワークレスポンスが正常ではありません。');
        }
        return response.json();
      })
      .then(data => {
        if (data.message_card_id) {
          let image_url = `/message_cards/${data.message_card_id}/image`;
          window.open(image_url, '_blank');
          window.location.href = `/message_cards`;
        }
      })
      .catch(error => {
        console.error('Fetch Error:', error);
        alert('エラーが発生しました');
      });
    });
  });
  