document.addEventListener("DOMContentLoaded", function() {
  const html = document.documentElement;

  // Check for saved theme preference or default to dark
  const currentTheme = localStorage.getItem("theme") || "dark";

  // Update button states
  updateButtonStates(currentTheme);

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
  }

  function updateButtonStates(theme) {
    document.getElementById("theme-light").classList.toggle("active", theme === "light");
    document.getElementById("theme-dark").classList.toggle("active", theme === "dark");
  }
});
