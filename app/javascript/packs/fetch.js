import 'select2'

const fetchApi = function() {
  $(document).ready(function () {
    $('.js-select-2').select2({
      placeholder: "Search Games",
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

    $('.js-select-2').on('select2:select', function (data) {
      console.log("I've been selected");
      // console.log(data);
      const game_id = data.params.data['id'];
      console.log(game_id);

      fetch(`https://api.boardgameatlas.com/api/search?ids=${game_id}&client_id=OShMmavExz`)
        .then(response => response.json())
        .then((data) => {
          const game = data.games[0];
          // console.log(data);
          // console.log(game['name']);
          // console.log(game['description']);
          // console.log(Math.round((game["min_playtime"] + game["max_playtime"])/2))
          // console.log(Math.round((game["min_players"] + game["max_players"])/2))
          // console.log(game['image_url']);

          const title = game['name'];
          const description = game['description'].replace(/<\/?[^>]+(>|$)/g, "");
          const suggested_numplayers = Math.round((game["min_players"] + game["max_players"]) / 2);
          const duration = Math.round((game["min_playtime"] + game["max_playtime"]) / 2);
          const image_url = game['image_url'];

          const form = document.getElementById('new_game')
          document.getElementById("game_title").value = title;
          document.getElementById("game_description").value = description;
          document.getElementById("game_duration").value = duration;
          document.getElementById("game_suggested_numplayers").value = suggested_numplayers;
          document.getElementById("game_image_url").value = image_url;
        });
    });
  });
}

export { fetchApi }
