Elm.Main.embed(document.getElementById('app'))

setTimeout(function () {
  document.querySelector('.app').classList.add('app--ready')
}, 300)
