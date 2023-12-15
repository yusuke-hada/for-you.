document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('registration_form');
  form.addEventListener('submit', async function(event) {
    event.preventDefault();
      let isValid = true;
      let name = document.getElementById('name').value;
      let email = document.getElementById('email').value;
      let password = document.getElementById('password').value;
      let passwordConfirmation = document.getElementById('password_confirmation').value;
      const pattern = /^[a-zA-Z0-9_+-]+(\.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/;
      
      if (name.length === 0) {
        document.getElementById('nameError').textContent = '名前を入力してください';
        document.getElementById('nameError').style.display = 'block';
        isValid = false;
      } else if (name.length > 252) {
        document.getElementById('nameError').textContent = '名前は252文字以下である必要があります';
        document.getElementById('nameError').style.display = 'block';
        isValid = false;
      } else {
        document.getElementById('nameError').style.display = 'none';
      }

      if (email.length === 0) {
        document.getElementById('emailError').textContent = 'メールアドレスを入力してください';
        document.getElementById('emailError').style.display = 'block';
        isValid = false;
      } else if (!pattern.test(email)) {
        document.getElementById('emailError').textContent = 'メールアドレスの形式で入力してください';
        document.getElementById('emailError').style.display = 'block';
        isValid = false;
      } else {
        const isUnique = await checkEmailUniqueness(email);
        if (!isUnique) {
          document.getElementById('emailError').textContent = 'このメールアドレスは既に使用されています';
          document.getElementById('emailError').style.display = 'block';
          isValid = false;
        } else {
          document.getElementById('emailError').style.display = 'none';
        }
      }

      if (password.length === 0) {
        document.getElementById('passwordError').textContent = 'パスワードを入力して下さい';
        document.getElementById('passwordError').style.display = 'block';
        isValid = false;
      } else if (password.length < 5){
        document.getElementById('passwordError').textContent = 'パスワードは5文字以上で入力して下さい';
        document.getElementById('passwordError').style.display = 'block';
        isValid = false;
      } else {
        document.getElementById('passwordError').style.display = 'none';
      }

      if (passwordConfirmation.length === 0) {
        document.getElementById('passwordConfirmationError').textContent = 'パスワード(確認)を入力してください';
        document.getElementById('passwordConfirmationError').style.display = 'block';
        isValid = false;
      } else if (password !== passwordConfirmation) {
        document.getElementById('passwordConfirmationError').textContent = 'パスワードが一致しません';
        document.getElementById('passwordConfirmationError').style.display = 'block';
        isValid = false;
      } else {
        document.getElementById('passwordConfirmationError').style.display = 'none';
      }

      if (isValid) {
        form.submit();
      }
    });
});

function checkEmailUniqueness(email) {
  return new Promise((resolve, reject) => {
    fetch(`/users/check_email?email=${encodeURIComponent(email)}`, {
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      method: 'GET',
      credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => resolve(!data.exists))
    .catch(error => {
      console.error('Error:', error);
      reject(error);
    });
  });
}