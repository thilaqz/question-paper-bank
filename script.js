async function searchPapers() {
  const college = document.getElementById("collegeInput").value.toLowerCase();
  const level = document.getElementById("levelSelect").value;
  const course = document.getElementById("courseInput").value.toLowerCase();
  const resultsDiv = document.getElementById("results");

  resultsDiv.innerHTML = "Searching...";

  const response = await fetch("data.json");
  const data = await response.json();

  const filtered = data.filter(item =>
    item.institution.toLowerCase().includes(college) &&
    item.level === level &&
    item.course.toLowerCase().includes(course)
  );

  if (filtered.length === 0) {
    resultsDiv.innerHTML = "<p>No question papers found.</p>";
    return;
  }

  resultsDiv.innerHTML = "";

  filtered.forEach(item => {
    const div = document.createElement("div");
    div.className = "paper";
    div.innerHTML = `
      <strong>${item.subject}</strong><br>
      ${item.institution} – ${item.course}<br>
      Year: ${item.year}<br>
      <a href="${item.file}" target="_blank">📄 View / Download</a>
    `;
    resultsDiv.appendChild(div);
  });
}
