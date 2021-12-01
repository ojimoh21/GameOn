import flatpickr from 'flatpickr';

const toggleDateInputs = function () {
  const startDateInput = document.getElementById('party_session_start_date');
  const endDateInput = document.getElementById('party_session_end_date');

  if (startDateInput) {
    if (startDateInput.value){
      flatpickr(endDateInput, {
        disableMobile: "true",
        minDate: startDateInput.value,
        dateFormat: "Y-m-d H:i",
        enableTime: true,
      });
    }
    else {
      endDateInput.disabled = true
    }
    flatpickr(startDateInput, {
      disableMobile: "true",
      minDate: "today",
      dateFormat:"Y-m-d H:i",
      enableTime: true,
    });


    startDateInput.addEventListener("change", (e) => {
      if (startDateInput != "") {
        endDateInput.disabled = false
      }
      flatpickr(endDateInput, {
        disableMobile: "true",
        minDate: e.target.value,
        dateFormat:"Y-m-d H:i",
        enableTime: true,
      });
    })
    endDateInput.addEventListener("change", (e) => {
      flatpickr(startDateInput, {
        disableMobile: "true",
        minDate: "today",
        maxDate: e.target.value,
        dateFormat: "Y-m-d H:i",
        enableTime: true,
      });
    })
  };

};
export { toggleDateInputs }
