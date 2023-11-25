function shuffle() {
  cards.forEach(card => {
    card.style.order = Math.floor(Math.random() * 19)
  });
}
let fliped = false; // variável de controle de etapa da jogada
let locked = false; // variável de controle de início de nova jogada
let previusClicked; // primeiro card clicado numa jogada
let flipedCounter = 0; // contador de pares encontrados

const icons = [ // Vetor contendo todo os nomes dos ícones dos cards
  "boi",
  "chacal",
  "leao",
  "macaco",
  "ovelha",
  "panda",
  "papagaio",
  "porco",
  "raposa",
  "urso",
];

function buildCards(icons) {
  return icons.concat(icons) // duplica os elementos do vetor
    .map((icon) => // transforma os nomes dos ícones num bloco html
      `<div class="memory-card" data-framework="ember">
              <img class="front-face" src="img/icon.webp" alt="Ember" />
              <img class="back-face hidden" src="img/${icon}.PNG" alt="JS card" />
      </div>`
    );
}

function shuffleCards() {
  cards.forEach(card => {
    card.style.order = Math.floor(Math.random() * 19)
  });
}


const container = document.querySelector(".memory-game");
container.innerHTML = buildCards(icons).join(''); // Insere todos os blocos na section

const cards = document.querySelectorAll(".memory-card"); // Obtém lista de cards
cards.forEach((card) => {
  card.addEventListener('click', () => {

    if (!(card.classList.contains("flip") || locked)) { // Evita duplo clique

      let frontFace = card.children[0]; // pega capa padrão
      let backFace = card.children[1]; // pega segunda imagem


      if (fliped) { // Executa se já houver uma virdada
        card.classList.add("flip");
        frontFace.classList.add("hidden");
        backFace.classList.remove("hidden");
        locked = true;
        setTimeout(() => {

          if (previusClicked.children[1].src != backFace.src) { // executa caso o usuário não acerte o par
            frontFace.classList.remove("hidden"); // ativa o hidden
            backFace.classList.add("hidden"); // desativa o hidden

            previusClicked.children[0].classList.remove("hidden"); // ativa o hidden
            previusClicked.children[1].classList.add("hidden"); // desativa o hidden
            card.classList.remove("flip"); // desvira carta
            previusClicked.classList.remove("flip"); // desvira carta

          } else {
            flipedCounter++;
            checkTriumph(); // Verifique se o jogador ganhou após encontrar um par
          }

          previusClicked = null;
          locked = false;

        }, 1000);

        fliped = false; // zera jogada

      } else { // executa se for uma nova jogada
        previusClicked = card; // armazena carta
        card.classList.add("flip"); // vira carta
        frontFace.classList.add("hidden");
        backFace.classList.remove("hidden");
        fliped = true;
      }
    }
  });
});

shuffleCards();

function checkTriumph() { // Método para verificar um triúnfo do jogador
  if (flipedCounter === icons.length) {// Verifico o valor da variável flipedCounter em relação ao número total de pares no jogo
    alert("Parabéns, você ganhou o jogo da memória!");
    restartGame(); // Reinicie o jogo
  }
}
function restartGame() {
  // Redefina todas as variáveis necessárias
  fliped = false;
  locked = false;
  previusClicked = null;
  flipedCounter = 0;

  // Remova a classe 'flip' de todas as cartas
  // cards.forEach(card => {
  //   card.classList.remove("flip");
  // });

  // Embaralhe as cartas novamente
  shuffleCards();
}