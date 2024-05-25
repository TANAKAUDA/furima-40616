document.addEventListener('DOMContentLoaded', () => {
  if (gon.public_key) {
    const payjp = Payjp(gon.public_key);
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    const form = document.getElementById('charge-form');
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      payjp.createToken(numberElement).then((response) => {
        if (response.error) {
        } else {
          const token = response.id;
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          form.insertAdjacentHTML('beforeend', tokenObj);

          document.getElementById('number-form').removeAttribute('name');
          document.getElementById('expiry-form').removeAttribute('name');
          document.getElementById('cvc-form').removeAttribute('name');

          form.submit();
        }
      });
    });
  }
});
