import { h, render } from 'preact';
import { getUserDataAndCsrfToken } from '../chat/util';
import { TagCollections } from '../tagCollections/tagCollections';

// var tagCollections = <%= @tagcollection %>

function loadElement() {
  getUserDataAndCsrfToken().then(({ currentUser }) => {
    console.log('aa', currentUser);
    const root = document.getElementById('tag-collections');
    // console.log('b', root.dataset.collections)
    const { collections } = root.dataset;
    // const arr = collections.split("\")
    const a = collections.split('"name":"');
    const pre = a.map(item => item.toString().split('"'));
    pre.shift();
    const names = pre.map(item => item[0]);
    // const tags = collections.split('tag_list')
    // console.log(names, tags)
    if (root) {
      render(
        <TagCollections availableTags={names} statusView={root.dataset.view} />,
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
