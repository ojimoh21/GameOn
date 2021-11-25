import { Controller } from "stimulus"

import 'select2'
import 'select2/dist/css/select2.css'

$(document).ready(function () {
  $('.js-select-2').select2({
    ajax: {
      url: `https://api.boardgameatlas.com/api/search`,
      data: function (params) {
        var query = {
          name: params.term,
          client_id: 'OShMmavExz'
        }

        // Query parameters will be ?search=[term]&type=public
        return query;
      },
      dataType: 'json',
      processResults: function (data) {
        const info = data.games.map(game => ({ "id": game.id, "text": game.name }))
        return {
          results: info
        };
      }
    }
  });
});

export default class extends Controller {

  static targets = ["query"]

  connect() {
    console.log("I'm here");
    console.log(this.queryTarget.value);
  }

  // search() {
  //   console.log(this.queryTarget.value);
  //   fetch(`https://api.boardgameatlas.com/api/search?name=${this.queryTarget.value}&client_id=OShMmavExz`)
  //     .then(response => response.json())
  //     .then((data) => {
  //       console.log(data)
  //       data.games.forEach((game) => {
  //         const gameTag = `<li class="list-inline-item">
  //           <img src="${game['thumb_url']}" alt="">
  //           <p>${game['name']}</p>
  //            ${game['description']}
  //         </li>`;
  //         games.insertAdjacentHTML("beforeend", gameTag);
  //       });
  //     });
  // }

  update() {
    const games = document.querySelector("#games");
    console.log(this.queryTarget.value);
    fetch(`https://api.boardgameatlas.com/api/search?name=${this.queryTarget.value}&client_id=OShMmavExz`)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        games.innerHTML = ''
        data.games.forEach((game) => {
          const gameTag = `<li class="list-inline-item">
            <p>${game['name']}</p>
          </li>`;
          games.insertAdjacentHTML("beforeend", gameTag);
        });
      });
    //  this.updateQueryParams()
  }

<<<<<<< HEAD
  submit() {
    const game = document.querySelector("#games-list");
    fetch("https://api.boardgameatlas.com/api/search?list_id=5yCPKRYJoF&client_id=OShMmavExz")
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      data.games.forEach((game) => {
        const gameTag = `<div class="game">
            <img src="${game['thumb_url']}" alt="" class="games-img">
            <p>${game['name']}</p>
          </li></div>`;
        game.insertAdjacentHTML("beforeend", gameTag);
      });
    });
  }
=======
//   fetch(`https://api.boardgameatlas.com/api/search?name=${}&client_id=OShMmavExz`)
//     .then(response => response.json())
//     .then((data) => {
//       console.log(data)
//       data.games.forEach((game) => {
//         const gameTag= `< li class="list-inline-item" >
//           <img src="${game['thumb_url']}" alt="">
//             <p>${game['name']}</p>
//             ${game['description']}
//           </li>`;
//         games.insertAdjacentHTML("beforeend", gameTag);
//     });
//   });
>>>>>>> master
}
