var generateButton = document.getElementById('social_generate');
var socialLoading = document.getElementById('social_loading');

// generateButton.addEventListener('click', function () {
//     generateButton.style.display = 'none';
//     socialLoading.style.display = 'block'
// });


function copyTextToClipboard() {
    const textarea = document.getElementById("content_area");
    textarea.select();
    textarea.setSelectionRange(0, 99999); // For mobile devices
    document.execCommand("copy");
    textarea.setSelectionRange(0, 0);
    const copyButton = document.getElementById("copyButton");
    copyButton.textContent = "Copied";
    setTimeout(function () {
        copyButton.textContent = "Copy Text";
    }, 3000);
}

const copyButton = document.getElementById("copyButton");
copyButton?.addEventListener("click", copyTextToClipboard);
