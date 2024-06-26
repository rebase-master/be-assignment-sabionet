// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$(document).ready(function() {
    $('#settle-expense').on('click', function (event) {
        $.ajax({
            url: '/settle/' + parseInt($(this).data('id')),
            method: 'POST',
            dataType: 'json', // Expect JSON response
            success: function(response) {
                alert(response.status);
                $('#settlementModal').modal('hide'); // Hide the modal
                window.location.reload(true);
            },
            error: function(xhr, status, error) {
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    let errors = xhr.responseJSON.error;
                    let errorMessage = "<ul>"
                    if (typeof errors === 'object') {
                        Object.keys(errors).forEach(function(key) {
                            errorMessage += "<li><strong>" + key + ":</strong> " + errors[key] + "</li>"
                            console.log('Key : ' + key + ', Value : ' + errors[key])
                        });
                    } else {
                        errorMessage += "<li>"+errors+"</li>"
                    }
                    errorMessage += "</ul>";

                    $('#ajax-errors').html(errorMessage).removeClass('d-none');
                } else {
                    $('#ajax-errors').text('An error occurred. Please try again.').removeClass('d-none');
                }
            }
        });

    });

    $('#new-expense-form').on('submit', function(event) {
        event.preventDefault();
        let $form = $(this);
        let ele = $form.find('input[type="submit"]');

        $.ajax({
            url: $form.attr('action'),
            method: $form.attr('method'),
            data: $form.serialize(),
            dataType: 'json', // Expect JSON response
            success: function(response) {
                $('#ajax-errors').addClass('d-none');
                alert('Expense successfully added.'); // Display success message
                $('#expenseModal').modal('hide'); // Hide the modal
                $form[0].reset();
                window.location.reload(true);
            },
            error: function(xhr, status, error) {
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    let errors = xhr.responseJSON.error;
                    let errorMessage = "<ul>"
                    if (typeof errors === 'object') {
                        Object.keys(errors).forEach(function(key) {
                            errorMessage += "<li><strong>" + key + ":</strong> " + errors[key] + "</li>"
                            console.log('Key : ' + key + ', Value : ' + errors[key])
                        });
                    } else {
                        errorMessage += "<li>"+errors+"</li>"
                    }
                    errorMessage += "</ul>";

                    $('#ajax-errors').html(errorMessage).removeClass('d-none');
                } else {
                    $('#ajax-errors').text('An error occurred. Please try again.').removeClass('d-none');
                }
            },
            complete: function () {
                ele.prop("disabled", false);
            }
        });
    });
});
