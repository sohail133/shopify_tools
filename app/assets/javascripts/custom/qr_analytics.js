$(document).ready(function () {
    $('.analytic_search_dropdown')?.change(function () {
        ajaxRequestAnalytic();
    });
});

function ajaxRequestAnalytic() {
    var formData = $('#analytic_search_form').serialize();
    $.ajax({
        type: 'Get',
        url: '/qr_analytics',
        data: formData,
        success: function (response) {
            console.log(response);
        },
        error: function (error) {
            console.error(error);
        }
    });
}

const start_date = document.getElementById('start-date-analytics');
const end_date = document.getElementById('end-date-analytics');
const period_date = document.getElementById('period-date-analytics');

// Add event listeners for start_date and end_date
start_date?.addEventListener('input', () => {
    if (start_date.value || end_date.value) {
        period_date.value = '';
    }
});

end_date?.addEventListener('input', () => {
    if (start_date.value || end_date.value) {
        period_date.value = '';
    }
});

// Add event listener for period_date
period_date?.addEventListener('input', () => {
    if (period_date.value) {
        start_date.value = '';
        end_date.value = '';
    }
});