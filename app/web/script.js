const API_BASE_URL = "__API_BASE_URL__";

async function loadPage() {
    const responseElement = document.getElementById("response");

    try {
        const res = await fetch(`${API_BASE_URL}/api/visit`);
        const data = await res.json();
        responseElement.textContent = `Visitor count: ${data.count}`;
    } catch (err) {
        responseElement.textContent = "Error loading API";
        console.error(err);
    }
}

loadPage();
