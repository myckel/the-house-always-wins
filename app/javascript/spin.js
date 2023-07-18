document.addEventListener("DOMContentLoaded", function() {
  const items = ['C', 'L', 'O', 'W'];
  const doors = document.querySelectorAll('.door');
  const spinnerButton = document.querySelector('.roll-button');
  spinnerButton.addEventListener('click', spin);

  async function fetchResult() {
    const appElement = document.getElementById('app');
    const rollUrl = appElement.dataset.rollUrl;
    const form = document.querySelector('.button_to');
    const token = form.querySelector('input[name="authenticity_token"]').value;

    const response = await fetch(rollUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': token
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    } else {
      const results = await response.json();
      return results;
    }
  }

  function init(firstInit = true, groups = 1, duration = 1) {
    for (const door of doors) {
      const boxes = door.querySelector('.boxes');
      const boxesClone = boxes.cloneNode(false);
      const pool = ['❓'];

      if (!firstInit) {
        const arr = [];
        for (let n = 0; n < (groups > 0 ? groups : 1); n++) {
          arr.push(...items);
        }

        pool.push(...shuffle(arr));
      }

      for (let i = pool.length - 1; i >= 0; i--) {
        const box = document.createElement('div');
        box.classList.add('box');
        box.style.width = door.clientWidth + 'px';
        box.style.height = door.clientHeight + 'px';
        box.textContent = pool[i];
        boxesClone.appendChild(box);
      }

      boxesClone.style.transitionDuration = `${duration > 0 ? duration : 1}s`;
      boxesClone.style.transform = `translateY(-${door.clientHeight * (pool.length - 1)}px)`;
      door.replaceChild(boxesClone, boxes);
    }
  }

  async function spin(event) {
    event.preventDefault();
    spinnerButton.disabled = true;
    const results = await fetchResult();

    init(false, results.roll_result.length, 2);

    for (let i = 0; i < doors.length; i++) {
      const door = doors[i];
      const boxes = door.querySelector('.boxes');
      const box = boxes.querySelector('.box');
      box.textContent = results.roll_result[i];

      boxes.style.transform = 'translateY(0)';
      await new Promise((resolve) => setTimeout(resolve, 1000));

      if (i === doors.length - 1) {
        await new Promise((resolve) => setTimeout(resolve, 1000));
        document.getElementById('credits-value').innerHTML = results.credits;
        spinnerButton.disabled = false;
      }
    }
  }


  function shuffle([...arr]) {
    let m = arr.length;
    while (m) {
      const i = Math.floor(Math.random() * m--);
      [arr[m], arr[i]] = [arr[i], arr[m]];
    }
    return arr;
  }

  init();
});
