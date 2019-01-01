var get_word_url = null;
var ch_no = null;

$(document).ready(function () {
  get_word_url = $('#get-word-url').html();
  var game_channel = $('#game-channel').html();
  if (game_channel) {
    ch_no = parseInt(game_channel);
    if (ch_no && (ch_no > 0)) {
      try {
        App.game = App.cable.subscriptions.create({
          channel: "GameChannel",
          id: ch_no
        }, {
          connected: function() {
            console.debug('channel #' + ch_no + ' connected');
          },
          disconnected: function() {
            console.debug('channel #' + ch_no + ' disconnected');
          },
          rejected: function() {
            console.error('channel #' + ch_no + ' rejected');
          },
          received: function(data) {
            if (data.word) {
              console.debug('channel #' + ch_no + ' received GameWord word=' + data.word + ' position=' + data.position);
              update_game_word(data.id);
            } else if (data.redirect) {
              console.debug('channel #' + ch_no + ' received redirect=' + data.redirect);
            }
          }
        });
      } catch (error) {
        console.error('channel #' + ch_no + ' ERROR: ' + error);
      }
    }
  }
});

function update_game_word(id)
{
  $.ajax({
    method: "GET",
    url: get_word_url,
    data: { game_word_id: id }
  })
  .done(function (data) {
    eval(data);
  })
  .fail(function (xhr) {
    console.error('Error getting cell update: ' + xhr.responseText);
  });
}
