function calculate() {
  const inputElement = document.getElementById("item-price")
  const taxElement = document.getElementById("add-tax-price")
  const profitElement = document.getElementById("profit")
    inputElement.addEventListener("input", () => {
      const input_price = document.getElementById("item-price")
      const price = input_price.value
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/calculated/?num=${price}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        }
        const item = XHR.response.post;
        taxElement.innerHTML = item.fee
        profitElement.innerHTML = item.profit
      }
    })
}

window.addEventListener("turbolinks:load", calculate);
