import { Controller } from "stimulus"


export default class extends Controller {

  static targets = ["query"]

  connect() {
    console.log("Controller is here");
    const game = document.querySelector(".hot-games-carousel");
    console.log(game);
    console.log("this is the hot games list")
    fetch("https://api.boardgameatlas.com/api/search?list_id=5yCPKRYJoF&client_id=OShMmavExz")
    .then(response => response.json())
    .then((data) => {
      console.log(data.games)
      data.games.forEach((g) => {
        console.log(g['image_url']);
        const gameTag = `<div class="mt-4 game">
          <img src="${g['image_url']}" alt="" class="games-img">
          </div>`;
        game.insertAdjacentHTML("beforeend", gameTag);
      });
    });
    // console.log(this.queryTarget.value);
  }

  // update() {
  //   const games = document.querySelector("#games");
  //   console.log(this.queryTarget.value);
  //   fetch(`https://api.boardgameatlas.com/api/search?name=${this.queryTarget.value}&client_id=OShMmavExz`)
  //     .then(response => response.json())
  //     .then((data) => {
  //       console.log(data)
  //       games.innerHTML = ''
  //       data.games.forEach((game) => {
  //         const gameTag = `<li class="list-inline-item">
  //           <p>${game['name']}</p>
  //         </li>`;
  //         games.insertAdjacentHTML("beforeend", gameTag);
  //       });
  //     });
  //   //  this.updateQueryParams()
  // }

  submit() {
  }

}
