const dino = document.getElementById('dino');
const rock = document.getElementById('rock');
const score = document.getElementById('score');

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

setInterval(() => {
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
