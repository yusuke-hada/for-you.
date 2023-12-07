document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('registration_form').addEventListener('submit', function(event) {
      let isValid = true;
      let name = document.getElementById('name').value;

      // nameのバリデーション
      if (name.length === 0) {
        document.getElementById('nameError').textContent = '名前を入力してください。';
        document.getElementById('nameError').style.display = 'block';
        isValid = false;
      } else if (name.length > 252) {
        document.getElementById('nameError').textContent = '名前は252文字以下である必要があります';
        document.getElementById('nameError').style.display = 'block';
        isValid = false;
      } else {
        document.getElementById('nameError').style.display = 'none';
      }

      // バリデーションが失敗した場合、フォームの送信を防ぐ
      if (!isValid) {
        event.preventDefault();
      }
    });
});
  