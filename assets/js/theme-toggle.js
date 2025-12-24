document.addEventListener("DOMContentLoaded", function() {
  const html = document.documentElement;

  // Check for saved theme preference or default to dark
  const currentTheme = localStorage.getItem("theme") || "dark";

  // Set initial theme
  setTheme(currentTheme);

  // Add click handlers
  document.getElementById("theme-light").addEventListener("click", function() {
    setTheme("light");
  });

  document.getElementById("theme-dark").addEventListener("click", function() {
    setTheme("dark");
  });

  function setTheme(theme) {
    html.classList.remove("theme-light", "theme-dark");
    html.classList.add("theme-" + theme);
    localStorage.setItem("theme", theme);
    updateButtonStates(theme);
    updateDiagrams(theme);  // Add this line!
  }

  function updateButtonStates(theme) {
    document.getElementById("theme-light").classList.toggle("active", theme === "light");
    document.getElementById("theme-dark").classList.toggle("active", theme === "dark");
  }

  function updateDiagrams(theme) {
    document.querySelectorAll('.theme-aware-diagram').forEach(img => {
      const src = theme === 'dark' ? img.dataset.darkSrc : img.dataset.lightSrc;
      if (src) {
        img.src = src;
      }
    });
  }
});
