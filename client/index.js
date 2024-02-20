const api = "http://localhost:3000";
const runButton = document.getElementById("runButton");
const addButton = document.getElementById("dataButton");

const runCall = async (phone, name) => {
    const data = { phone, name };
    await fetch(`${api}/call`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
    });
};

const addData = async (policy, patientName, patientDOB) => {
    const data = { policy, patientName, patientDOB };
    await fetch(`${api}/cms`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
    });
};
// 919318466808
//18552528782
//18886323862
//18006151883 (vp)
runButton.addEventListener("click", async () => {
    runCall("919318466808", "Peter")
});

addButton.addEventListener("click", async () => {
    addData("123456", "Peter", "May 29 2000")
});
