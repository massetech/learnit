import MainView from '../main';

export default class View extends MainView {
  mount() {
    super.mount()
    console.log('PageTestView mounted')

    $(".button").click(function() {
      alert("btn clicked")
      console.log(window.localStorage)
    })

    $(document).ready(function () {
      var mySwiper = new Swiper ('.swiper-container', {
        direction: 'horizontal',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        loop: true
      })
    })

    // localStorage.setItem("test", "<%= assigns[:user_token] %>")
    // alert( "learnit-data = " + localStorage.getItem("learnit-data"))
    // console.log(localStorage.getItem("learnit-data"))
    // console.log(JSON.parse(localStorage.getItem("learnit-data"), undefined, 2));
    //let assets = window.Gon.assets()
    let data = window.Gon.getAsset('memberships')
    localStorage.setItem("learnit-data", data)
    console.log(data)
    let test = localStorage.getItem("learnit-data")[:list_id]
    alert(test)
  }

  unmount() {
    super.unmount()
    console.log('PageTestView unmounted')


  }
}
