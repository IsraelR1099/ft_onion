const dino = document.getElementById('dino');
const rock = document.getElementById('rock');
const score = document.getElementById('score');
const game = document.getElementById('game');
const startButton = document.getElementById('startButton');
let gameIntervale;


function startGame() {
	startButton.style.display = 'none';
	dino.style.display = 'block';
	rock.style.display = 'block';
	game.style.display = 'block';

	gameIntervale = setInterval(() => {
		const dinoTop = parseInt(window.getComputedStyle(dino).getPropertyValue('top'));
		const rockLeft = parseInt(window.getComputedStyle(rock).getPropertyValue('left'));

		if (rockLeft < 0) {
			rock.style.display = 'none';
		} else {
			rock.style.display = '';
		}

		if (rockLeft < 50 && rockLeft > 0 && dinoTop >= 140) {
			alert('You lose! Your score is: ' + score.innerText + '\nClick OK to restart the game.');
			location.reload();
		}
		score.innerText++;
	}, 50);
}

function jump() {
	dino.classList.add('jump-animation');
	setTimeout(() => {
		dino.classList.remove('jump-animation');
	}, 500);
}

document.addEventListener('keydown', (event) => {
	if (!dino.classList.contains('jump-animation')) {
		if (event.code === 'Space') {
			jump();
		}
	}
});


startButton.addEventListener('click', startGame);
