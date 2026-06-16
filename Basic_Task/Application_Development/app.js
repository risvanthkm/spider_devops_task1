const inputBox = document.getElementById("input");
const subButton = document.getElementById("submit");

const players_no = document.getElementById("players_no");
const bots_no = document.getElementById("bots_no");
const target = document.getElementById("target");
const winner = document.getElementById("winner");

subButton.addEventListener("click" , () => {
    
    const user_input = Number(inputBox.value);

    if (user_input < 0 || user_input > 100) {
        alert("Please enter a number between 0 and 100");
        return;
    }

    const bot_input = randNum();
    let targetValue = (user_input + bot_input)/2;
    targetValue = Math.floor(targetValue * 0.8);

    players_no.innerHTML = `${user_input}`;
    bots_no.innerHTML = `${bot_input}`;
    target.innerHTML = `${targetValue}`;

    const userDiff = Math.abs(user_input - targetValue);
    const botDiff = Math.abs(bot_input - targetValue);

    if (userDiff < botDiff) {
        winner.textContent = "USER";
        winner.style.color = "green";
    } else if (botDiff < userDiff) {
        winner.textContent = "BOT";
        winner.style.color = "red";
    } else {
        winner.textContent = "DRAW";
    }
});

const randNum = () => Math.floor(Math.random() * 101);