import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["content", "query"]

  connect() {
    console.log(this.contentTarget);
  }

  search() {
    console.log(this.queryTarget.value);
  }

  fetch(`https://api.boardgameatlas.com/api/search?name=${}&client_id=OShMmavExz`)
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      data.games.forEach((game) => {
        const gameTag= `< li class="list-inline-item" >
          <img src="${game['thumb_url']}" alt="">
            <p>${game['name']}</p>
            ${game['description']}
          </li>`;
        games.insertAdjacentHTML("beforeend", gameTag);
    });
  });
}
