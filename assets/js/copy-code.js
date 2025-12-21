// Add copy buttons to code blocks
document.addEventListener("DOMContentLoaded", function() {
  // Find all code blocks
  const codeBlocks = document.querySelectorAll("pre.highlight, figure.highlight pre, div.highlighter-rouge pre");
  
  codeBlocks.forEach(function(codeBlock) {
    // Create button
    const button = document.createElement("button");
    button.className = "copy-code-button";
    button.textContent = "Copy";
    
    // Add click handler
    button.addEventListener("click", function() {
      const code = codeBlock.querySelector("code") || codeBlock;
      navigator.clipboard.writeText(code.textContent).then(function() {
        button.textContent = "Copied!";
        setTimeout(function() {
          button.textContent = "Copy";
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
