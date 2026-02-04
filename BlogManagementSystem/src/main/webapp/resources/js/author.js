document.addEventListener('DOMContentLoaded', function() {
    // ===== Rich Text Editor Enhancement =====
    const contentEditor = document.querySelector('textarea.editor');
    
    if (contentEditor) {
        // Add basic formatting toolbar
        const toolbar = document.createElement('div');
        toolbar.className = 'editor-toolbar';
        toolbar.innerHTML = `
            <button type="button" data-command="bold"><i class="fas fa-bold"></i></button>
            <button type="button" data-command="italic"><i class="fas fa-italic"></i></button>
            <button type="button" data-command="underline"><i class="fas fa-underline"></i></button>
            <button type="button" data-command="insertUnorderedList"><i class="fas fa-list-ul"></i></button>
            <button type="button" data-command="insertOrderedList"><i class="fas fa-list-ol"></i></button>
        `;
        
        contentEditor.parentNode.insertBefore(toolbar, contentEditor);
        
        toolbar.querySelectorAll('button').forEach(btn => {
            btn.addEventListener('click', function() {
                document.execCommand(this.dataset.command, false, null);
            });
        });
    }
    
    // ===== Auto-save Draft =====
    const postForm = document.querySelector('.post-form');
    if (postForm) {
        let autoSaveTimer;
        const formInputs = postForm.querySelectorAll('input, textarea, select');
        
        formInputs.forEach(input => {
            input.addEventListener('input', function() {
                clearTimeout(autoSaveTimer);
                autoSaveTimer = setTimeout(() => {
                    saveDraft();
                }, 5000);
            });
        });
        
        function saveDraft() {
            const formData = new FormData(postForm);
            console.log('Auto-saving draft...');
            // Implement AJAX save here
        }
    }
    
    // ===== Image Preview =====
    const imageInput = document.querySelector('input[type="file"][accept*="image"]');
    if (imageInput) {
        imageInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    let preview = document.querySelector('.image-preview');
                    if (!preview) {
                        preview = document.createElement('img');
                        preview.className = 'image-preview';
                        preview.style.maxWidth = '200px';
                        preview.style.marginTop = '10px';
                        imageInput.parentNode.appendChild(preview);
                    }
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    }
    
    // ===== Tag Selection Enhancement =====
    const tagSelect = document.querySelector('select[name="tagIds"]');
    if (tagSelect && tagSelect.multiple) {
        tagSelect.addEventListener('change', function() {
            const selected = Array.from(this.selectedOptions).map(opt => opt.text);
            console.log('Selected tags:', selected);
        });
    }
});
