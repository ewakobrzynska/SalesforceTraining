document.querySelector('input[type="submit"]').addEventListener('click', function (event) {
    const firstNameInput = document.getElementById('first_name');
    const lastNameInput = document.getElementById('last_name');
    const phoneInput = document.getElementById('phone');
    const emailInput = document.getElementById('email');

    let isValid = true;
    let missingFields = [];
    let errorMessages = [];

    if (firstNameInput.value.trim() === '') {
        firstNameInput.style.border = '1px solid red';
        isValid = false;
        missingFields.push('First Name');
    } else if (!/^[a-zA-Z]+$/.test(firstNameInput.value.trim())) {
        firstNameInput.style.border = '1px solid red';
        isValid = false;
        errorMessages.push('First Name must contain only letters.');
    } else {
        firstNameInput.style.border = '';
    }

    if (lastNameInput.value.trim() === '') {
        lastNameInput.style.border = '1px solid red';
        isValid = false;
        missingFields.push('Last Name');
    } else if (!/^[a-zA-Z]+$/.test(lastNameInput.value.trim())) {
        lastNameInput.style.border = '1px solid red';
        isValid = false;
        errorMessages.push('Last Name must contain only letters.');
    } else {
        lastNameInput.style.border = '';
    }

    if (phoneInput.value.trim() === '') {
        phoneInput.style.border = '1px solid red';
        isValid = false;
        missingFields.push('Phone Number');
    } else if (!/^(\+)[0-9]+$/.test(phoneInput.value.trim())) {
        phoneInput.style.border = '1px solid red';
        isValid = false;
        errorMessages.push('Phone Number must start with +xx and contain only digits.');
    } else {
        phoneInput.style.border = '';
    }

    if (emailInput.value.trim() === '') {
        emailInput.style.border = '1px solid red';
        isValid = false;
        missingFields.push('Email Address');
    } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailInput.value.trim())) {
        emailInput.style.border = '1px solid red';
        isValid = false;
        errorMessages.push('Email Address is incorrect. Please check it.');
    } else {
        emailInput.style.border = '';
    }

    if (!isValid) {
        event.preventDefault();
        const dialogBox = document.createElement('div');
        dialogBox.style.position = 'fixed';
        dialogBox.style.top = '50%';
        dialogBox.style.left = '50%';
        dialogBox.style.transform = 'translate(-50%, -50%)';
        dialogBox.style.background = 'white';
        dialogBox.style.padding = '20px';
        dialogBox.style.border = '1px solid black';
        dialogBox.style.borderRadius = '10px';
        dialogBox.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.5)';
        let message = `Please fill in the following fields: <br>${missingFields.join(', ')}.`;
        if (errorMessages.length > 0) {
            message += `<br>Errors: <br>${errorMessages.join('<br>')}`;
        }
        dialogBox.innerHTML = message;
        document.body.appendChild(dialogBox);
        setTimeout(() => {
            dialogBox.remove();
        }, 3000);
    } else {
        document.querySelector('form').submit();
    }
});