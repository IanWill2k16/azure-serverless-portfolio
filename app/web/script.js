async function loadMessage() {
    const responseElement = document.getElementById("response");

    try {
        const res = await fetch("API_URL_HERE/api/hello");
        const data = await res.json();
        responseElement.textContent = data.message;
    } catch (err) {
        responseElement.textContent = "Error loading API";
    }
}

loadMessage();
