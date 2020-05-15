import { h, render } from 'preact';
import { getUserDataAndCsrfToken } from '../chat/util';
import { TagCollections } from '../tagCollections/tagCollections';

function loadElement() {
  getUserDataAndCsrfToken().then(() => {
    const root = document.getElementById('tag-collections');
    if (root) {
      render(
        <TagCollections
          availableTags={['front end', 'back end']}
          statusView={root.dataset.view}
        />,
        root,
        root.firstElementChild,
      );
    }
  });
}

window.InstantClick.on('change', () => {
  loadElement();
});

loadElement();
