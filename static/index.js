
window.onload = () => {
    setInterval(getWeight, 500);
}

async function getWeight() {
    const getWeightEndpoint = `${apiBaseUrl}/weight`,
        requestHeaders = new Headers();

    const weightApiRes = await fetch(getWeightEndpoint, {
        method: 'GET',
        headers: requestHeaders
    });

    weightRes = await weightApiRes.json();

    if (weightRes > 0) {
        weightValueArea = document.querySelector('.weight-display');
        weightValueArea.innerText = weightRes;
    };
}