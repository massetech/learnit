import MainView    from './main';
import PageIndexView from './page/index';

// Collection of specific view modules
const views = {
  PageIndexView,
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
