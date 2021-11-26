import 'select2'
import 'select2/dist/css/select2.css'

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
});
