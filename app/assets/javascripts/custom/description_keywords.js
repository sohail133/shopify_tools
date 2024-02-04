document.addEventListener('DOMContentLoaded', function () {
    const tagsInput = document.getElementById('tags-input');
    const hiddenTagsInput = document.getElementById('hidden-tags-input');
    const tagsContainer = document.getElementById('tags-container');
    const MAX_TAG_LENGTH = 30;

    function removeTag(tagElement, tag) {
        hiddenTagsInput.value = hiddenTagsInput.value.replace(`${tag},`, '');
        tagsContainer.removeChild(tagElement);
    }

    hiddenTagsInput?.value.split(',').forEach(tag => {
        if (tag.trim() !== '') {
            const tagElement = document.createElement('span');
            tagElement.classList.add('tag');
            tagElement.textContent = tag.trim();

            const tagRemove = document.createElement('span');
            tagRemove.classList.add('tag-remove');
            tagRemove.innerHTML = '&#10006;';
            tagRemove.setAttribute('data-tag', tag.trim());
            tagRemove.addEventListener('click', function () {
                removeTag(tagElement, tag.trim());
            });

            tagElement.appendChild(tagRemove);
            tagsContainer.appendChild(tagElement);
        }
    });

    tagsInput?.addEventListener('keydown', function (event) {
        const tagText = tagsInput.value.trim();

        if ((event.key === ' ' || event.key === ',' || event.key === 'Enter') && tagText !== '') {
            event.preventDefault();

            const limitedTagText = tagText.slice(0, MAX_TAG_LENGTH);

            const tagElement = document.createElement('span');
            tagElement.classList.add('tag');
            tagElement.textContent = limitedTagText;

            const tagRemove = document.createElement('span');
            tagRemove.classList.add('tag-remove');
            tagRemove.innerHTML = '&#10006;';
            tagRemove.setAttribute('data-tag', limitedTagText);
            tagRemove.addEventListener('click', function () {
                removeTag(tagElement, limitedTagText);
            });

            tagElement.appendChild(tagRemove);
            tagsContainer.appendChild(tagElement);
            hiddenTagsInput.value += `${limitedTagText},`;
            tagsInput.value = '';
        }

    });
});


document.addEventListener("DOMContentLoaded", function () {
    var formFields = document.querySelectorAll("form input[type='text']");

    formFields?.forEach(function (field) {
        field.addEventListener("keydown", function (event) {
            if (event.keyCode === 13) {
                event.preventDefault();
            }
        });
    });

    var ai_description = document.getElementById('ai_description');
    ai_description?.addEventListener("keyup", function (event) {
        document.getElementById('save_updated_content').style.display = 'block';
    })
});
