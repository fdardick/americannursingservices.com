// Validates resume submit form.  Displays dialog if any errors.
// Returns false if errors, true otherwise.
function validate_submit(form) {

  var form = document.resumeForm;

  var errors = "";
  if (form.name.value.length == 0) {
    errors += "Name is required.";
  }

  if (form.phone.value.length == 0) {
    errors += "\nPhone is required.";
  }
    
  if (form.email.value.length == 0) {
    errors += "\nEmail is required.";
  }

  if (errors.length > 0) {
    alert(errors);
    return false;
  }

  return true;
}
