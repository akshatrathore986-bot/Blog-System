// ===== Simple Rich Text Editor =====
class SimpleEditor {
    constructor(selector) {
        this.textarea = document.querySelector(selector);
        if (!this.textarea) return;
        
        this.init();
    }
    
    init() {
        this.createToolbar();
        this.attachEvents();
    }
    
    createToolbar() {
        const toolbar = document.createElement('div');
        toolbar.className = 'editor-toolbar';
        toolbar.innerHTML = `
            <button type="button" class="tool-btn" data-command="bold" title="Bold">
                <i class="fas fa-bold"></i>
            </button>
            <button type="button" class="tool-btn" data-command="italic" title="Italic">
                <i class="fas fa-italic"></i>
            </button>
            <button type="button" class="tool-btn" data-command="underline" title="Underline">
                <i class="fas fa-underline"></i>
            </button>
            <span class="separator"></span>
            <button type="button" class="tool-btn" data-command="h1" title="Heading 1">
                H1
            </button>
            <button type="button" class="tool-btn" data-command="h2" title="Heading 2">
                H2
            </button>
            <button type="button" class="tool-btn" data-command="h3" title="Heading 3">
                H3
            </button>
            <span class="separator"></span>
            <button type="button" class="tool-btn" data-command="ul" title="Bullet List">
                <i class="fas fa-list-ul"></i>
            </button>
            <button type="button" class="tool-btn" data-command="ol" title="Numbered List">
                <i class="fas fa-list-ol"></i>
            </button>
            <span class="separator"></span>
            <button type="button" class="tool-btn" data-command="link" title="Insert Link">
                <i class="fas fa-link"></i>
            </button>
            <button type="button" class="tool-btn" data-command="image" title="Insert Image">
                <i class="fas fa-image"></i>
            </button>
        `;
        
        this.textarea.parentNode.insertBefore(toolbar, this.textarea);
    }
    
    attachEvents() {
        const buttons = document.querySelectorAll('.editor-toolbar .tool-btn');
        buttons.forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                this.executeCommand(btn.dataset.command);
            });
        });
    }
    
    executeCommand(command) {
        const textarea = this.textarea;
        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const selectedText = textarea.value.substring(start, end);
        let replacement = selectedText;
        
        switch(command) {
            case 'bold':
                replacement = `<strong>${selectedText}</strong>`;
                break;
            case 'italic':
                replacement = `<em>${selectedText}</em>`;
                break;
            case 'underline':
                replacement = `<u>${selectedText}</u>`;
                break;
            case 'h1':
                replacement = `<h1>${selectedText}</h1>`;
                break;
            case 'h2':
                replacement = `<h2>${selectedText}</h2>`;
                break;
            case 'h3':
                replacement = `<h3>${selectedText}</h3>`;
                break;
            case 'ul':
                replacement = `<ul>\n\t<li>${selectedText}</li>\n</ul>`;
                break;
            case 'ol':
                replacement = `<ol>\n\t<li>${selectedText}</li>\n</ol>`;
                break;
            case 'link':
                const url = prompt('Enter URL:');
                if (url) replacement = `<a href="${url}">${selectedText}</a>`;
                break;
            case 'image':
                const imgUrl = prompt('Enter image URL:');
                if (imgUrl) replacement = `<img src="${imgUrl}" alt="${selectedText}">`;
                break;
        }
        
        textarea.value = textarea.value.substring(0, start) + replacement + textarea.value.substring(end);
        textarea.focus();
        textarea.setSelectionRange(start, start + replacement.length);
    }
}

// Initialize editor
document.addEventListener('DOMContentLoaded', function() {
    if (document.querySelector('textarea.editor')) {
        new SimpleEditor('textarea.editor');
    }
});
