// Add copy buttons to code blocks
document.addEventListener("DOMContentLoaded", function() {
  // Find all code blocks
  const codeBlocks = document.querySelectorAll("pre.highlight, figure.highlight pre, div.highlighter-rouge pre");
  
  codeBlocks.forEach(function(codeBlock) {
    // Create button
    const button = document.createElement("button");
    button.className = "copy-code-button";
    button.setAttribute("aria-label", "Copy code");
    
    // Copy icon SVG
    const copyIcon = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect>
      <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path>
    </svg>`;
    
    // Checkmark icon SVG (for "copied" state)
    const checkIcon = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="20 6 9 17 4 12"></polyline>
    </svg>`;
    
    button.innerHTML = copyIcon;
    
    // Add click handler
    button.addEventListener("click", function() {
      const code = codeBlock.querySelector("code") || codeBlock;
      navigator.clipboard.writeText(code.textContent).then(function() {
        button.innerHTML = checkIcon;
        setTimeout(function() {
          button.innerHTML = copyIcon;
        }, 2000);
      });
    });
    
    // Wrap code block and add button
    const wrapper = document.createElement("div");
    wrapper.className = "code-block-wrapper";
    codeBlock.parentNode.insertBefore(wrapper, codeBlock);
    wrapper.appendChild(codeBlock);
    wrapper.appendChild(button);
  });
});
