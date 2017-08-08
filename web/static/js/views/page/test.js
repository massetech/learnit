import MainView from '../main';

export default class View extends MainView {
  mount() {
    super.mount();

    // Specific logic here
    console.log('PageTestView mounted')
    // let memberships = window.Gon.getAsset('memberships')
    console.log(memberships)
    // $("body").addClass("bg-img");
    // $("nav").removeClass("has-shadow").addClass("back-transparent");
    // $("footer").hide();
  }

  unmount() {
    super.unmount();

    // Specific logic here
    console.log('PageTestView unmounted');
  }
}
