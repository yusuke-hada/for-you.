document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('registration_form').addEventListener('submit', function(event) {
    let isValid = true;
    let age = document.getElementById('age').value;
    let gender = document.getElementById('gender').value;
    let business = document.getElementById('business').value;
    let hobby = document.getElementById('hobby').value;

    if (age === "") {
        document.getElementById('ageError').textContent = '年齢を入力してください';
        document.getElementById('ageError').style.display = 'block';
        isValid = false;
    } else if (parseInt(age) < 0 || parseInt(age) > 120) {
        document.getElementById('ageError').textContent = '有効な年齢を入力してください(0〜120の間)';
        document.getElementById('ageError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('ageError').style.display = 'none';
    }

    if (gender === ""){
        document.getElementById('genderError').textContent = '性別を選んでください';
        document.getElementById('genderError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('genderError').style.display = 'none';
    }

    if (business.length > 20 ){
        document.getElementById('businessError').textContent = '職業は20文字以内である必要があります';
        document.getElementById('businessError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('businessError').style.display = 'none';
    }

    if (hobby.length > 255 ){
        document.getElementById('hobbyError').textContent = '趣味は255文字以内である必要があります';
        document.getElementById('hobbyError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('hobbyError').style.display = 'none';
    }

    if (!isValid) {
        event.preventDefault();
    }

    });
});
  