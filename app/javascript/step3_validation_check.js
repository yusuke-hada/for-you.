document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('registration_form').addEventListener('submit', function(event) {
        let isValid = true;
        let item_name = document.getElementById('item_name').value;
        let description = document.getElementById('description').value;

        if (item_name.length === 0) {
            document.getElementById('item_nameError').textContent = '欲しいものを入力して下さい';
            document.getElementById('item_nameError').style.display = 'block';
            isValid = false;
          } else if (item_name.length > 252) {
            document.getElementById('item_nameError').textContent = '欲しいものは252文字以下である必要があります';
            document.getElementById('item_nameError').style.display = 'block';
            isValid = false;
          } else {
            document.getElementById('item_nameError').style.display = 'none';
          }

        if (description.length === 0) {
          document.getElementById('descriptionError').textContent = '詳細を入力して下さい';
          document.getElementById('descriptionError').style.display = 'block';
          isValid = false;
        } else if (description.length > 252) {
          document.getElementById('descriptionError').textContent = '詳細は252文字以下である必要があります';
          document.getElementById('descriptionError').style.display = 'block';
          isValid = false;
        } else {
          document.getElementById('descriptionError').style.display = 'none';
        }
        
        if (!isValid) {
            event.preventDefault();
        }

    });
});